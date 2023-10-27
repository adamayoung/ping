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
        store.sites
    }

    var body: some View {
        Table(sites) {
            TableColumn("NAME", value: \.name)
            TableColumn("URL") { site in
                Text(site.url.absoluteString)
            }
        }
        .navigationTitle("SUMMARY")
    }

}

#Preview {
    SummaryView()
}
