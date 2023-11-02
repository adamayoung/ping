//
//  SiteRow.swift
//  Ping
//
//  Created by Adam Young on 30/10/2023.
//

import PingKit
import SwiftUI

struct SiteRow: View {

    var site: Site
    var siteStatus: SiteStatus

    var body: some View {
        SiteStatusLabel(site: site, siteStatus: siteStatus)
    }

}

#Preview {
    let state = PingState.preview

    return NavigationStack {
        List {
            ForEach(state.sites.all) { site in
                let status = state.sites.siteStatus(for: site)
                NavigationLink(destination: EmptyView()) {
                    SiteRow(
                        site: site,
                        siteStatus: status
                    )
                }
            }
        }
#if os(macOS)
        .listStyle(.sidebar)
#endif
    }
}
