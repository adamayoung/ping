//
//  SiteRowContextMenu.swift
//  Ping
//
//  Created by Adam Young on 14/11/2023.
//

import PingData
import SwiftData
import SwiftUI

struct SiteRowContextMenu: View {

    @Query(sort: [SortDescriptor(\SiteGroup.name, comparator: .localizedStandard)]) private var siteGroups: [SiteGroup]

    var onDelete: () -> Void

    var body: some View {
        Menu {
            ForEach(siteGroups) { siteGroup in
                Button {

                } label: {
                    Text(verbatim: siteGroup.name)
                }
                .accessibilityIdentifier("siteContentMenuAddToSiteGroupButton-group-\(siteGroup.id.uuidString)")
            }
        } label: {
            Label("ADD_TO_SITE_GROUP", systemImage: "plus.rectangle.on.folder.fill")
        }
        .accessibilityIdentifier("siteContentMenuAddToSiteGroupButton")

        Divider()

        Button(role: .destructive) {
            onDelete()
        } label: {
            Label("DELETE", systemImage: "trash")
        }
        .accessibilityIdentifier("siteContentMenuDeleteButton")
    }

}

#Preview {
    SiteRowContextMenu(onDelete: { })
}
