//
//  SitesView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import PingKit
import SwiftUI

struct SitesView: View {

    @Binding var menuItem: MenuItem?

    @Environment(PingStore.self) private var store
    @State private var isAddingSite = false

    private var sites: [Site] {
        store.sites.all
    }

    private func siteStatus(for site: Site) -> SiteStatus {
        store.sites.siteStatus(for: site)
    }

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
                    Task {
                        await refreshAllSiteStatuses()
                    }
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
            await refreshAllSiteStatuses()
        }
        #endif
        .sheet(isPresented: $isAddingSite) {
            AddSiteSheetView()
                .environment(store)
        }
        .navigationTitle("SITES")
        .task {
            await fetchData()
        }
    }

}

extension SitesView {

    private var summaryRow: some View {
        NavigationLink(value: MenuItem.summary) {
            Label("SUMMARY", systemImage: "tablecells")
                .accessibilityIdentifier("summaryNavigationLink")
        }
    }

    private var siteRows: some View {
        ForEach(sites) { site in
            NavigationLink(value: MenuItem.site(site)) {
                SiteRow(site: site, siteStatus: siteStatus(for: site))
            }
            .accessibilityIdentifier("siteNavigationLink-\(site.id.uuidString)")
        }
        .onDelete(perform: delete)
    }

}

extension SitesView {

    private func fetchData() async {
        if sites.isEmpty {
            await store.send(.sites(.fetchLatestSiteStatuses))
            await store.send(.sites(.fetch))
        }
    }

    private func refreshAllSiteStatuses() async {
        await store.send(.sites(.checkAllSiteStatuses))
    }

    private func delete(at offsets: IndexSet) {
        guard let site = (offsets.map { sites[$0] }).first else {
            return
        }

        Task {
            await store.send(.sites(.remove(site)))
        }
    }

}

#Preview {
    let store = PingStore.preview()

    return NavigationStack {
        SitesView(menuItem: .constant(.summary))
    }
    .environment(store)
}
