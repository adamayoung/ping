//
//  DetailView.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import PingData
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
    NavigationStack {
        DetailView(menuItem: .constant(.summary))
    }
    .siteStatusCheckerService(preview: true)
    .generateSampleData()
    .pingDataContainer(inMemory: true)
}

#Preview("Site") {
    NavigationStack {
        DetailView(menuItem: .constant(.site(.gitHub)))
    }
    .siteStatusCheckerService(preview: true)
    .generateSampleData()
    .pingDataContainer(inMemory: true)
}

#Preview("No Site Selected") {
    return NavigationStack {
        DetailView(menuItem: .constant(nil))
    }
    .siteStatusCheckerService(preview: true)
    .generateSampleData()
    .pingDataContainer(inMemory: true)
}
