//
//  ContentView.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import PingKit
import SwiftUI

struct ContentView: View {

    @State private var menuItem: MenuItem? = .default
    @State private var path: [MenuItem] = []

    var body: some View {

        NavigationSplitView {
            SitesView(menuItem: $menuItem)
        } detail: {
            switch menuItem {
            case .summary:
                SummaryView()

            case .site(let site):
                SiteView(site: site) {
                    menuItem = nil
                }

            default:
                ContentUnavailableView {
                    Text("NO_SITE_SELECTED")
                }
            }
        }
        #if os(macOS)
        .frame(minWidth: 600, minHeight: 450)
        #endif
        .navigationSplitViewStyle(.prominentDetail)
    }

}

#Preview {
    let store = PingStore.preview

    return ContentView()
        .environment(store)
}
