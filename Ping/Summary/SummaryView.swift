//
//  SummaryView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import SwiftData
import SwiftUI

struct SummaryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(SiteStatusCheckerService.self) private var siteStatusCheckerService

    @State private var isAddingSite = false

    @Query(sort: [SortDescriptor(\Site.name, comparator: .localizedStandard)]) private var sites: [Site]
    @Query private var requests: [SiteStatusRequest]
    @Query(sort: [SortDescriptor(\SiteStatus.timestamp, order: .reverse)]) private var statuses: [SiteStatus]

    var body: some View {
        Table(sites) {
            TableColumn("STATUS") { site in
                let status = latestStatus(for: site)
                HStack {
                    Spacer()
                    SiteStatusLabel(
                        site: site,
                        siteStatus: status,
                        isCheckingStatus: siteStatusCheckerService.isChecking(site: site.id)
                    )
                    .labelStyle(.iconOnly)
                    Spacer()
                }
            }
            .width(40)

            TableColumn("NAME", value: \.name)

            TableColumn("URL") { site in
                let requestURLString = request(for: site)?.url.absoluteString ?? " - "
                Text(verbatim: requestURLString)
            }
        }
        .opacity(sites.isEmpty ? 0 : 1)
        .overlay {
            if sites.isEmpty {
                NoSitesView {
                    isAddingSite = true
                }
            }
        }
        .sheet(isPresented: $isAddingSite) {
            AddSiteSheetView()
                .modelContext(modelContext)
        }
        .navigationTitle("SUMMARY")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

}

extension SummaryView {

    private func latestStatus(for site: Site) -> SiteStatus? {
        statuses.first(where: { $0.site?.persistentModelID == site.persistentModelID })
    }

    private func request(for site: Site) -> SiteStatusRequest? {
        requests.first(where: { $0.site?.persistentModelID == site.persistentModelID })
    }

}

#if os(macOS)
#Preview("Summary") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingFactory.shared.siteStatusCheckerService

    return NavigationStack {
        SummaryView()
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}

#Preview("Summary - No Sites") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingFactory.shared.siteStatusCheckerService
    try? modelContainer.mainContext.delete(model: Site.self)

    return NavigationStack {
        SummaryView()
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}
#endif
