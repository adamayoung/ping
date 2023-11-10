//
//  SitesView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import SwiftData
import SwiftUI

struct SitesView: View {

    @Binding var menuItem: MenuItem?

    @Environment(\.modelContext) private var modelContext
    @Environment(SiteStatusCheckerService.self) private var siteStatusCheckerService

    @State private var isAddingSite = false

    @Query(sort: [SortDescriptor(\Site.name, comparator: .localizedStandard)]) private var sites: [Site]
    @Query(sort: [SortDescriptor(\SiteStatus.timestamp, order: .reverse)]) private var statuses: [SiteStatus]

    var body: some View {
        List(selection: $menuItem) {
#if os(macOS)
            Section {
                summaryRow
            }
            Section("SITES") {
                siteRows
            }
#else
            Section {
                siteRows
            }
#endif
        }
        .accessibilityIdentifier("sidebar")
        .scrollDisabled(sites.isEmpty)
#if os(iOS)
        .overlay {
            if sites.isEmpty {
                NoSitesView {
                    isAddingSite.toggle()
                }
            }
        }
#endif
#if os(macOS)
        .listStyle(.sidebar)
#else
        .listStyle(.insetGrouped)
#endif
        .toolbar {
#if os(macOS)
            ToolbarItem(placement: .primaryAction) {
                Button {
                    refreshAllSiteStatuses()
                } label: {
                    Label("REFRESH_SITE_STATUS", systemImage: "arrow.clockwise")
                }
                .help("REFRESH_SITE_STATUS")
                .accessibilityIdentifier("refreshAllSiteStatusesButton")
            }
#endif

            ToolbarItem(placement: .primaryAction) {
                Button {
                    isAddingSite.toggle()
                } label: {
                    Label("ADD_SITE", systemImage: "plus")
                }
                .help("ADD_SITE")
                .accessibilityIdentifier("addSiteToolbarButton")
            }
        }
#if os(iOS)
        .refreshable {
            refreshAllSiteStatuses()
        }
#endif
        .sheet(isPresented: $isAddingSite) {
            AddSiteSheetView()
                .modelContext(modelContext)
        }
        .navigationTitle("SITES")
    }

}

extension SitesView {

    @MainActor private var summaryRow: some View {
        NavigationLink(value: MenuItem.summary) {
            Label("SUMMARY", systemImage: "tablecells")
                .accessibilityIdentifier("summaryNavigationLink")
        }
    }

    @MainActor private var siteRows: some View {
        ForEach(sites) { site in
            NavigationLink(value: MenuItem.site(site)) {
                SiteRow(
                    site: site,
                    siteStatus: latestStatus(for: site),
                    isCheckingStatus: siteStatusCheckerService.isChecking(site: site.id)
                )
            }
            .accessibilityIdentifier("siteNavigationLink-\(site.id.uuidString)")
        }
        .onDelete(perform: delete)
    }

}

extension SitesView {

    @MainActor
    private func latestStatus(for site: Site) -> SiteStatus? {
        statuses.first(where: { $0.site == site })
    }

    @MainActor
    private func refreshAllSiteStatuses() {
        for site in sites {
            guard let requestTask = SiteRequestTask(siteRequest: site.request) else {
                continue
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
    }

    private func delete(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sites[index])
            }
        }
    }

}

#Preview("Sites") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingPreviewFactory.shared.siteStatusCheckerService

    return NavigationStack {
        SitesView(menuItem: .constant(.summary))
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}
