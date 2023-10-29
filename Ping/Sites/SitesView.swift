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
    @State private var showingSheet = false

    private var sites: [Site] {
        store.sites.all
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
        .scrollDisabled(sites.isEmpty)
        #if os(iOS)
        .overlay {
            if sites.isEmpty {
                NoSitesView()
            }
        }
        #endif
        #if os(macOS)
        .listStyle(.sidebar)
        #endif
        .toolbar {
            ToolbarItem {
                Button {
                    showingSheet.toggle()
                } label: {
                    Label("ADD_SITE", systemImage: "plus")
                }
                .accessibilityIdentifier("addSiteToolbarButton")
            }
        }
        .sheet(isPresented: $showingSheet) {
            #if os(macOS)
            macOSAddSiteView
            #else
            iOSAddSiteView
            #endif
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
            Label("SUMMARY", systemImage: "globe")
                .accessibilityIdentifier("summaryNavigationLink")
        }
    }

    private var siteRows: some View {
        ForEach(sites) { site in
            NavigationLink(value: MenuItem.site(site)) {
                Label(site.name, systemImage: "globe")
            }
            .accessibilityIdentifier("siteNavigationLink-\(site.id.uuidString)")
        }
        .onDelete(perform: delete)
    }

    private var macOSAddSiteView: some View {
        AddSiteView()
            .padding()
            .frame(width: 300)
            .environment(store)
    }

    private var iOSAddSiteView: some View {
        NavigationView {
            AddSiteView()
                .environment(store)
        }
    }

}

extension SitesView {

    private func fetchData() async {
        if sites.isEmpty {
            await store.send(.sites(.fetch))
        }
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
    let store = PingStore.preview

    return NavigationStack {
        SitesView(menuItem: .constant(.summary))
    }
    .environment(store)
}
