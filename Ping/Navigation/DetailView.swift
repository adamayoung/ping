//
//  DetailView.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import SwiftData
import SwiftUI

struct DetailView: View {

    @Binding var menuItem: MenuItem?

    var body: some View {
        switch menuItem {
        case .summary:
            SummaryView()

        case .site(let site):
            SiteView(site: site) {
                menuItem = nil
            }
            .id(site.id)

        default:
            SiteNotSelectedView()
        }
    }
}

#Preview("Summary") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingFactory.shared.siteStatusCheckerService

    return NavigationStack {
        DetailView(menuItem: .constant(.summary))
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}

#Preview("Site") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingFactory.shared.siteStatusCheckerService

    return NavigationStack {
        DetailView(menuItem: .constant(.site(Site.gitHubPreview)))
            .modelContainer(modelContainer)
            .environment(siteStatusCheckerService)
    }
}
