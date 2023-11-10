//
//  SitesView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import SwiftData
import SwiftUI

struct SitesView: View {

    @Binding var menuItem: MenuItem?

    @Environment(\.modelContext) private var modelContext
    @Environment(SiteStatusCheckerService.self) private var siteStatusCheckerService

    @State private var isAddingSite = false
    @State private var isAddingSiteGroup = false

    @Query(sort: [SortDescriptor(\SiteGroup.name, comparator: .localizedStandard)]) private var siteGroups: [SiteGroup]
    @Query(sort: [SortDescriptor(\Site.name, comparator: .localizedStandard)]) private var sites: [Site]
    @Query(sort: [SortDescriptor(\SiteStatus.timestamp, order: .reverse)]) private var statuses: [SiteStatus]

    var body: some View {
        List(selection: $menuItem) {
            #if os(macOS)
            Section {
                summaryRow
            }
            #endif

            ForEach(siteGroups) { siteGroup in
                let sites = sites(for: siteGroup)
                Section {
                    siteRows(for: sites)
                } header: {
                    Text(verbatim: siteGroup.name)
                }
            }

            let otherSites = sites(for: nil)
            if !otherSites.isEmpty {
                Section {
                    siteRows(for: otherSites)
                } header: {
                    Text("OTHER")
                }
            }
        }
        .accessibilityIdentifier("sidebar")
        .scrollDisabled(sites.isEmpty)
#if os(iOS)
        .overlay {
            if sites.isEmpty {
                NoSitesView {
                    isAddingSite.toggle()
                }
            }
        }
#endif
#if os(macOS)
        .listStyle(.sidebar)
#else
        .listStyle(.insetGrouped)
#endif
        .toolbar {
//#if os(macOS)
//            ToolbarItem(placement: .primaryAction) {
//                Button {
//                    refreshAllSiteStatuses()
//                } label: {
//                    Label("REFRESH_SITE_STATUS", systemImage: "arrow.clockwise")
//                }
//                .help("REFRESH_SITE_STATUS")
//                .accessibilityIdentifier("refreshAllSiteStatusesButton")
//            }
//#endif
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Section {
                        Button {
                            refreshAllSiteStatuses()
                        } label: {
                            Label("CHECK_ALL", systemImage: "wifi")
                        }
                        .disabled(sites.isEmpty)
                        .help("CHECK_ALL_SITE_STATUSES")
                        .accessibilityIdentifier("checkAllToolbarButton")
                    }

                    Section {
                        Button {
                            isAddingSite.toggle()
                        } label: {
                            Label("ADD_SITE", systemImage: "plus")
                        }
                        .help("ADD_SITE")
                        .accessibilityIdentifier("addSiteToolbarButton")

                        Button {
                            isAddingSiteGroup.toggle()
                        } label: {
                            Label("ADD_SITE_GROUP", systemImage: "folder.fill.badge.plus")
                        }
                        .help("ADD_SITE_GROUP")
                        .accessibilityIdentifier("addSiteGroupToolbarButton")
                    }
                } label: {
                    Label("SITES_MENU", systemImage: "ellipsis.circle")
                }
            }
        }

#if os(iOS)
        .refreshable {
            refreshAllSiteStatuses()
        }
#endif
        .sheet(isPresented: $isAddingSite) {
            AddSiteSheetView()
                .modelContext(modelContext)
        }
        .sheet(isPresented: $isAddingSiteGroup) {
            AddSiteGroupSheetView()
                .modelContext(modelContext)
        }
        .navigationTitle("SITES")
    }

}

extension SitesView {

    @MainActor private var summaryRow: some View {
        NavigationLink(value: MenuItem.summary) {
            Label("SUMMARY", systemImage: "tablecells")
                .accessibilityIdentifier("summaryNavigationLink")
        }
    }

    @MainActor
    @ViewBuilder
    private func siteRows(for sites: [Site]) -> some View {
        ForEach(sites) { site in
            NavigationLink(value: MenuItem.site(site)) {
                SiteRow(
                    site: site,
                    siteStatus: latestStatus(for: site),
                    isCheckingStatus: siteStatusCheckerService.isChecking(site: site.id)
                )
            }
            .accessibilityIdentifier("siteNavigationLink-\(site.id.uuidString)")
        }
        .onDelete(perform: delete)
    }

}

extension SitesView {

    @MainActor
    private func latestStatus(for site: Site) -> SiteStatus? {
        statuses.first(where: { $0.site == site })
    }

    @MainActor
    private func sites(for siteGroup: SiteGroup?) -> [Site] {
        let siteGroupID = siteGroup?.id
        return (try? sites.filter(#Predicate { $0.group?.id == siteGroupID })) ?? []
    }

    @MainActor
    private func refreshAllSiteStatuses() {
        for site in sites {
            guard let requestTask = SiteStatusRequestTask(siteRequest: site.request) else {
                continue
            }

            Task {
                await self.siteStatusCheckerService.checkSiteStatus(using: requestTask)
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sites[index])
            }

            try? modelContext.save()
        }
    }

}

#Preview("Sites") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingFactory.shared.siteStatusCheckerService

    return NavigationStack {
        SitesView(menuItem: .constant(.summary))
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}
