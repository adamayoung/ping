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
        store.sites.siteStatus(for: site)
    }

    private var siteStatusLabel: String {
        switch siteStatus.statusCode {
        case .checking:
            return "Checking..."

        case .success:
            return "Success"

        case .failure:
            return "Failure"

        case .unknown:
            return "Unknown"
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Text(verbatim: site.url.absoluteString)
                SiteStatusLabel(site: site, siteStatus: siteStatus)
            }
        }
        .navigationTitle(site.name)
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

    private func refreshSiteStatus() {
        Task {
            await store.send(.sites(.checkSiteStatus(site)))
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
            sites: SitesState(
                siteStatuses: [
                    site.id: SiteStatus(statusCode: .success)
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: .preview)
    }
    .environment(store)
}

#Preview("Failure") {
    let site = Site.previews[1]

    let store = PingStore.preview(
        state: PingState(
            sites: SitesState(
                siteStatuses: [
                    site.id: SiteStatus(
                        statusCode: .failure(SiteStatusError(errorDescription: "Some error"))
                    )
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: site)
    }
    .environment(store)
}

#Preview("Checking") {
    let site = Site.previews[2]

    let store = PingStore.preview(
        state: PingState(
            sites: SitesState(
                siteStatuses: [
                    site.id: SiteStatus(statusCode: .checking)
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: site)
    }
    .environment(store)
}

#Preview("Unknown") {
    let site = Site.previews[3]

    let store = PingStore.preview(
        state: PingState(
            sites: SitesState(
                siteStatuses: [
                    site.id: SiteStatus(statusCode: .unknown)
                ]
            )
        )
    )

    return NavigationStack {
        SiteView(site: site)
    }
    .environment(store)
}
