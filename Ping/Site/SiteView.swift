//
//  SiteView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import SwiftData
import SwiftUI

struct SiteView: View {

    var site: Site
    var onDelete: (() -> Void)?

    private static let statusesFetchLimit = 10

    private static var siteStatusesFetchDescriptor: FetchDescriptor<SiteStatus> {
        var descriptor = FetchDescriptor<SiteStatus>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        descriptor.fetchLimit = 10
        return descriptor
    }

    @Environment(\.modelContext) private var modelContext
    @Environment(SiteStatusCheckerService.self) private var siteStatusCheckerService

    @State private var isConfirmDeleteAlertPresented = false

    @Query(siteStatusesFetchDescriptor) private var statuses: [SiteStatus]

    private var currentStatus: SiteStatus? {
        statuses.first
    }

    private var currentStatusCode: SiteStatus.Code {
        currentStatus?.statusCode ?? .unknown
    }

    init(site: Site, onDelete: (() -> Void)? = nil) {
        self.site = site
        self.onDelete = onDelete
        let siteID = site.id
        self._statuses = Query(filter: #Predicate { $0.site?.id == siteID }, sort: \.timestamp, order: .reverse)
    }

    var body: some View {
        List {
            HStack {
                Spacer()
                SiteStatusHeaderView(
                    site: site,
                    siteStatus: currentStatus,
                    isCheckingStatus: siteStatusCheckerService.isChecking(site: site.id),
                    refreshSiteStatus: {
                        refreshSiteStatus()
                    }
                )
                Spacer()
            }
            .listRowInsets(.none)
            .listRowSeparator(.hidden)
            .listRowBackground(EmptyView())

            if case let .failure(message) = currentStatusCode {
                Section(header: Text("ERROR")) {
                    Text(verbatim: message)
                }
            }

            if !statuses.isEmpty {
                Section("PREVIOUS_STATUS_CHECKS") {
                    ForEach(Array(statuses.prefix(10))) { status in
                        Label(
                            title: {
                                VStack(alignment: .leading) {
                                    Text(status.statusCode.localizedName)
                                    if case let .failure(message) = currentStatusCode {
                                        Text(verbatim: message)
                                            .font(.caption)
                                            .foregroundStyle(Color.secondary)
                                    }
                                }
                            },
                            icon: {
                                Image(systemName: status.statusCode.iconName)
                                    .foregroundStyle(status.statusCode.iconColor)
                            }
                        )
                    }
                }
            }
        }
        #if os(iOS)
        .refreshable {
            refreshSiteStatus()
        }
        #endif
        .navigationTitle(site.name)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        #if os(macOS)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    refreshSiteStatus()
                } label: {
                    Label("REFRESH_SITE_STATUS", systemImage: "arrow.clockwise")
                }
                .help("REFRESH_SITE_STATUS")
                .disabled(siteStatusCheckerService.isChecking(site: site.id))
                .accessibilityIdentifier("refreshSiteStatusButton")
            }

            ToolbarItem(placement: .destructiveAction) {
                Button(role: .destructive) {
                    confirmRemove()
                } label: {
                    Label("DELETE_SITE", systemImage: "trash")
                }
                .help("DELETE_SITE")
                .accessibilityIdentifier("deleteSiteButton")
            }
        }
        #endif
        .confirmationDialog("CONFIRM_DELETE_SITE", isPresented: $isConfirmDeleteAlertPresented) {
            Button(role: .destructive) {
                removeSite()
            } label: {
                Text("DELETE")
            }
            .accessibilityIdentifier("confirmDeleteSiteButton")

            Button("CANCEL", role: .cancel) {
            }
            .help("CANCEL")
            .accessibilityIdentifier("cancelDeleteSiteButton")
        }
    }

}

extension SiteView {

    @MainActor
    private func refreshSiteStatus() {
        guard let requestTask = SiteRequestTask(siteRequest: site.request) else {
            return
        }

        Task {
            let (statusCode, time) = await self.siteStatusCheckerService.checkSiteStatus(using: requestTask)
            let status = SiteStatus(statusCode: statusCode, time: time)

            await MainActor.run {
                withAnimation {
                    if site.statuses == nil {
                        site.statuses = []
                    }

                    site.statuses?.append(status)
                }
            }
        }
    }

    private func confirmRemove() {
        isConfirmDeleteAlertPresented = true
    }

    private func removeSite() {
        withAnimation {
            modelContext.delete(site)
        }

        onDelete?()
    }

}

#Preview("Success") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingPreviewFactory.shared.siteStatusCheckerService
    let site = Site.gitHubPreview

    return NavigationStack {
        SiteView(site: site)
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}

#Preview("Failure") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingPreviewFactory.shared.siteStatusCheckerService
    let site = Site.googlePreview

    return NavigationStack {
        SiteView(site: site)
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}

#Preview("Checking") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingPreviewFactory.shared.siteStatusCheckerService
    let site = Site.microsoftPreview

    return NavigationStack {
        SiteView(site: site)
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}

#Preview("Unknown") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingPreviewFactory.shared.siteStatusCheckerService
    let site = Site.twitterPreview

    return NavigationStack {
        SiteView(site: site)
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}
