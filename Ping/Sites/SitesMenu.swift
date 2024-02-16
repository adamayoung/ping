//
//  SitesMenu.swift
//  Ping
//
//  Created by Adam Young on 14/11/2023.
//

import SwiftUI

struct SitesMenu: View {

    var canRefreshAllSites: Bool
    @Binding var isAddingSite: Bool
    @Binding var isAddingSiteGroup: Bool
    @Binding var isManagingSiteGroups: Bool
    var onRefreshAllSiteStatuses: () -> Void

    var body: some View {
        Menu {
            Section {
                Button {
                    onRefreshAllSiteStatuses()
                } label: {
                    Label("REFRESH_SITE_STATUSES", systemImage: "arrow.clockwise")
                }
                .disabled(!canRefreshAllSites)
                .help("CHECK_ALL_SITE_STATUSES")
                .accessibilityIdentifier("refreshSiteStatusesToolbarButton")
            }

            Section {
                Button {
                    isAddingSite.toggle()
                } label: {
                    Label("ADD_SITE", systemImage: "plus")
                }
                .help("ADD_SITE")
                .accessibilityIdentifier("addSiteToolbarMenuButton")
            }

            Section {
                Button {
                    isAddingSiteGroup.toggle()
                } label: {
                    Label("ADD_SITE_GROUP", systemImage: "folder.fill.badge.plus")
                }
                .help("ADD_SITE_GROUP")
                .accessibilityIdentifier("addSiteGroupToolbarMenuButton")

                Button {
                    isManagingSiteGroups.toggle()
                } label: {
                    Label("MANAGED_SITE_GROUPS", systemImage: "folder.fill")
                }
                .help("MANAGED_SITE_GROUPS")
                .accessibilityIdentifier("manageSiteGroupsToolbarMenuButton")
            }
        } label: {
            Label("SITES_MENU", systemImage: "ellipsis.circle")
        }
        .accessibilityIdentifier("sitesActionToolbarMenuButton")
    }

}

#Preview("Menu - Can refresh sites") {
    NavigationStack {
        List {
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                SitesMenu(
                    canRefreshAllSites: true,
                    isAddingSite: .constant(false),
                    isAddingSiteGroup: .constant(false),
                    isManagingSiteGroups: .constant(false),
                    onRefreshAllSiteStatuses: { }
                )
            }
        }
    }
}

#Preview("Menu - Can't refresh sites") {
    NavigationStack {
        List {
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                SitesMenu(
                    canRefreshAllSites: false,
                    isAddingSite: .constant(false),
                    isAddingSiteGroup: .constant(false),
                    isManagingSiteGroups: .constant(false),
                    onRefreshAllSiteStatuses: { }
                )
            }
        }
    }
}
