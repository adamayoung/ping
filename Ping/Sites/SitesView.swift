//
//  SitesView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import PingKit
import SwiftUI

struct SitesView: View {

    @Environment(PingStore.self) private var store
    @Binding var menuItem: MenuItem?
    @State private var showingSheet = false

    private var sites: [Site] {
        store.sites
    }

    var body: some View {
        List(selection: $menuItem) {
            #if os(macOS)
            Section {
                NavigationLink(value: MenuItem.summary) {
                    Label("SUMMARY", systemImage: "globe")
                }
            }
            #endif

            Section("SITES") {
                ForEach(sites) { site in
                    NavigationLink(value: MenuItem.site(site)) {
                        Label(site.name, systemImage: "globe")
                    }
                }
            }

        }
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
            }
        }
        .sheet(isPresented: $showingSheet) {
            #if os(macOS)
            AddSiteView()
                .padding()
                .frame(width: 300)
                .environment(store)
            #else
            NavigationView {
                AddSiteView()
                    .environment(store)
            }
            #endif
        }
        .navigationTitle("SITES")
        .task {
            if sites.isEmpty {
                await store.send(.fetchSites)
            }
        }
        .alert(isPresented: <#T##Binding<Bool>#>, error: <#T##LocalizedError?#>, actions: <#T##(LocalizedError) -> View#>, message: <#T##(LocalizedError) -> View#>)
    }

}

#Preview {
    let store = PingStore.preview

    return SitesView(menuItem: .constant(.summary))
        .environment(store)
}
