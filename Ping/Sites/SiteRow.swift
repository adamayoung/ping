//
//  SiteRow.swift
//  Ping
//
//  Created by Adam Young on 30/10/2023.
//

import PingData
import SwiftData
import SwiftUI

struct SiteRow: View {

    var site: Site
    var siteStatus: SiteStatus?
    var isCheckingStatus: Bool
    var onDelete: () -> Void

    var body: some View {
        SiteStatusLabel(site: site, siteStatus: siteStatus, isCheckingStatus: isCheckingStatus)
            #if os(macOS)
            .contextMenu {
                SiteRowContextMenu(
                    onDelete: onDelete
                )
            }
            #endif
    }

}

//#Preview {
//    let sites: [Site] = [] //(try? modelContainer.mainContext.fetch(FetchDescriptor<Site>())) ?? []
//
//    NavigationStack {
//        List {
//            ForEach(sites) { site in
//                Section {
//                    NavigationLink(destination: EmptyView()) {
//                        SiteRow(
//                            site: site,
//                            siteStatus: site.latestStatus,
//                            isCheckingStatus: siteStatusCheckerService.isChecking(site: site.id),
//                            onDelete: { }
//                        )
//                    }
//                }
//            }
//        }
//        #if os(macOS)
//        .listStyle(.sidebar)
//        #else
//        .listStyle(.insetGrouped)
//        #endif
//    }
//    .siteStatusCheckerService(preview: true)
//    .generateSampleData()
//    .pingDataContainer(inMemory: true)
//}
