//
//  ContentView.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import PingKit
import SwiftUI

struct ContentView: View {

    @State private var columnVisibility = NavigationSplitViewVisibility.all
    @State private var menuItem: MenuItem? = .default
    @State private var path: [MenuItem] = []

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SitesView(menuItem: $menuItem)
                #if os(iOS)
                .toolbar(removing: .sidebarToggle)
                #endif
        } detail: {
            switch menuItem {
            case .summary:
                SummaryView()
                    .navigationBarTitleDisplayMode(.inline)

            case .site(let site):
                SiteView(site: site) {
                    menuItem = nil
                }
                .id(site.id)
                .navigationBarTitleDisplayMode(.inline)

            default:
                SiteNotSelectedView()
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationSplitViewStyle(.balanced)
        #if os(macOS)
        .frame(minWidth: 600, minHeight: 450)
        #endif
    }

}

#Preview {
    let store = PingStore.preview()

    return ContentView()
        .environment(store)
}
