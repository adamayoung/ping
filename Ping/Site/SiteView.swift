//
//  SiteView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import PingKit
import SwiftUI

struct SiteView: View {

    var site: Site
    var onDelete: (() -> Void)?

    @Environment(PingStore.self) private var store
    @State private var isConfirmDeleteAlertPresented = false

    private var siteStatus: SiteStatus {
        store.siteStatuses.latestSiteStatus(for: site)
    }

    var body: some View {
        List {
            HStack {
                Spacer()
                SiteStatusHeaderView(site: site, siteStatus: siteStatus, refreshSiteStatus: refreshSiteStatus)
                Spacer()
            }
            .listRowInsets(.none)
            .listRowSeparator(.hidden)
            .listRowBackground(EmptyView())

            if case let .failure(error) = siteStatus.statusCode {
                Section(header: Text("ERROR")) {
                    Text(verbatim: error.localizedDescription)
                }
            }
        }
#if os(iOS)
        .refreshable {
            refreshSiteStatus()
        }
#endif
        .navigationTitle(site.name)
#if os(macOS)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    refreshSiteStatus()
                } label: {
                    Label("REFRESH_SITE_STATUS", systemImage: "arrow.clockwise")
                }
                .help("REFRESH_SITE_STATUS")
                .disabled(siteStatus.statusCode == .checking)
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

    private func refreshSiteStatus() {
        Task {
            await store.send(.siteStatuses(.checkSiteStatus(site)))
        }
    }

    private func confirmRemove() {
        isConfirmDeleteAlertPresented = true
    }

    private func removeSite() {
        Task {
            await store.send(.sites(.remove(site)))
            await MainActor.run {
                onDelete?()
            }
        }
    }

}

#Preview("Success") {
    let site = Site.previews[0]

    let store = PingStore.preview(
        state: PingState(
            siteStatuses: SiteStatusesState(
                all: [
                    site.id: [
                        SiteStatus(statusCode: .success, time: 5)
                    ]
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: site)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .environment(store)
    }
    .frame(maxWidth: .infinity)
}

#Preview("Failure") {
    let site = Site.previews[1]

    let store = PingStore.preview(
        state: PingState(
            siteStatuses: SiteStatusesState(
                all: [
                    site.id: [
                        SiteStatus(
                            statusCode: .failure(SiteStatusError(errorDescription: "Some error")),
                            time: 5
                        )
                    ]
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: site)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .environment(store)
    }
    .frame(maxWidth: .infinity)
}

#Preview("Checking") {
    let site = Site.previews[2]

    let store = PingStore.preview(
        state: PingState(
            siteStatuses: SiteStatusesState(
                all: [
                    site.id: [
                        SiteStatus(statusCode: .checking, time: 5)
                    ]
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: site)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .environment(store)
    }
    .frame(maxWidth: .infinity)
}

#Preview("Unknown") {
    let site = Site.previews[3]

    let store = PingStore.preview(
        state: PingState(
            siteStatuses: SiteStatusesState(
                all: [
                    site.id: [
                        SiteStatus(statusCode: .unknown, time: 5)
                    ]
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: site)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .environment(store)
    }
    .frame(maxWidth: .infinity)
}
