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
                Text(verbatim: siteStatusLabel)
                if case let .failure(error) = siteStatus.statusCode {
                    Text(verbatim: error.localizedDescription)
                }
            }

        }
        .navigationTitle(site.name)
        .toolbar {
            ToolbarItem {
                Button {
                    Task {
                        await store.send(.sites(.checkSiteStatus(site)))
                    }
                } label: {
                    Label("REFRESH_SITE_STATUS", systemImage: "arrow.clockwise")
                }
                .accessibilityIdentifier("refreshSiteStatusButton")
            }

            ToolbarItem {
                Button(role: .destructive) {
                    confirmRemove()
                } label: {
                    Label("DELETE_SITE", systemImage: "trash")
                }
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

            Button("CANCEL", role: .cancel) { }
                .accessibilityIdentifier("cancelDeleteSiteButton")
        }
    }

    private func confirmRemove() {
        isConfirmDeleteAlertPresented = true
    }

    private func removeSite() {
        Task {
            await store.send(.sites(.remove(site)))
        }

        onDelete?()
    }

}

#Preview("Success") {
    let site = Site.preview

    let store = PingStore(
        state: PingState(
            sites: SitesState(
                siteStatuses: [
                    site.id: SiteStatus.preview(.success)
                ]
            )
        ),
        inMemoryStorage: true
    )

    return NavigationStack {
        SiteView(site: .preview)
    }
    .environment(store)
}

#Preview("Failure") {
    let site = Site.previews[1]

    let store = PingStore(
        state: PingState(
            sites: SitesState(
                siteStatuses: [
                    site.id: SiteStatus.preview(
                        .failure(SiteStatusError(errorDescription: "Some error"))
                    )
                ]
            )
        ),
        inMemoryStorage: true
    )

    return NavigationStack {
        SiteView(site: site)
    }
    .environment(store)
}

#Preview("Unknown") {
    let site = Site.previews[2]

    let store = PingStore(
        state: PingState(
            sites: SitesState(
                siteStatuses: [
                    site.id: SiteStatus.preview(.unknown)
                ]
            )
        ),
        inMemoryStorage: true
    )

    return NavigationStack {
        SiteView(site: site)
    }
    .environment(store)
}
