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
    @State private var isManagingSiteGroups = false

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

            siteGroupSections

            nonSiteGroupSection
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
            ToolbarItem(placement: .primaryAction) {
                SitesMenu(
                    canRefreshAllSites: !sites.isEmpty,
                    isAddingSite: $isAddingSite,
                    isAddingSiteGroup: $isAddingSiteGroup,
                    isManagingSiteGroups: $isManagingSiteGroups,
                    onRefreshAllSiteStatuses: {
                        refreshAllSiteStatuses()
                    }
                )
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
        .sheet(isPresented: $isManagingSiteGroups) {
            ManageSiteGroupsSheetView()
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

    @MainActor private var siteGroupSections: some View {
        ForEach(siteGroups) { siteGroup in
            let sites = sites(for: siteGroup)
            if !sites.isEmpty {
                Section {
                    siteRows(for: sites)
                } header: {
                    Text(verbatim: siteGroup.name)
                }
            }
        }
    }

    @MainActor @ViewBuilder private var nonSiteGroupSection: some View {
        let otherSites = sites(for: nil)
        if !otherSites.isEmpty {
            Section {
                siteRows(for: otherSites)
            } header: {
                Text("OTHER")
            }
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
                    isCheckingStatus: siteStatusCheckerService.isChecking(site: site.id),
                    onDelete: {
                        delete(site: site)
                    }
                )
            }
            .accessibilityIdentifier("siteNavigationLink-\(site.id.uuidString)")
        }
        #if os(iOS)
        .onDelete(perform: { indexSet in
            delete(at: indexSet, in: sites)
        })
        #endif
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

    private func delete(at offsets: IndexSet, in sites: [Site]) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sites[index])
            }

            do {
                try modelContext.save()
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
    }

    private func delete(site: Site) {
        withAnimation {
            menuItem = MenuItem.default
            modelContext.delete(site)

            do {
                try modelContext.save()
            } catch let error {
                fatalError(error.localizedDescription)
            }
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

#Preview("No Sites") {
    let modelContainer = PingFactory.shared.modelContainer
    let siteStatusCheckerService = PingFactory.shared.siteStatusCheckerService
    try? modelContainer.mainContext.delete(model: Site.self)

    return NavigationStack {
        SitesView(menuItem: .constant(.summary))
    }
    .modelContainer(modelContainer)
    .environment(siteStatusCheckerService)
}
