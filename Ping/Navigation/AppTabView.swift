//
//  AppTabView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import SwiftUI

struct AppTabView: View {

    @AppStorage("selectedTab") private var selectedTab: Tab = .sites

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                SitesView()
            }
            .tabItem {
                Label("SITES", systemImage: "globe")
            }
            .tag(Tab.sites)
        }
    }
}

extension AppTabView {

    private enum Tab: String {
        case sites
    }

}

#Preview {
    AppTabView()
}
