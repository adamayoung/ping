//
//  SummaryView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import PingKit
import SwiftUI

struct SummaryView: View {

    @Environment(PingStore.self) private var store

    private var sites: [Site] {
        store.sites.all
    }

    private func siteStatus(for site: Site) -> SiteStatus {
        store.siteStatuses.latestSiteStatus(for: site)
    }

    var body: some View {
        Table(sites) {
            TableColumn("STATUS") { site in
                HStack {
                    Spacer()
                    SiteStatusLabel(site: site, siteStatus: siteStatus(for: site))
                        .labelStyle(.iconOnly)
                    Spacer()
                }

            }
            .width(40)

            TableColumn("NAME", value: \.name)

            TableColumn("URL") { site in
                Text(site.request.url.absoluteString)
            }
        }
        .navigationTitle("SUMMARY")
    }

}

#Preview {
    let store = PingStore.preview()

    return NavigationStack {
        SummaryView()
    }
    .environment(store)
}
