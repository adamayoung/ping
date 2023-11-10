//
//  ContentView.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import SwiftData
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
            DetailView(menuItem: $menuItem)
        }
        .navigationSplitViewStyle(.balanced)
        #if os(macOS)
        .frame(minWidth: 600, minHeight: 450)
        #endif
    }

}

#Preview("Content") {
    let modelContainer = ModelContainer.preview
    let siteStatusCheckerService = SiteStatusCheckerService.preview

    return ContentView()
        .modelContainer(modelContainer)
        .environment(siteStatusCheckerService)
}
