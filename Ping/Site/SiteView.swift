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

    var body: some View {
        ScrollView {
            Text(verbatim: site.url.absoluteString)
        }
        .navigationTitle(site.name)
        .toolbar {
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

#Preview {
    let store = PingStore.preview

    return NavigationStack {
        SiteView(site: .preview)
    }
    .environment(store)
}
