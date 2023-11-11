//
//  NoSiteGroupsView.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import SwiftUI

struct NoSiteGroupsView: View {

    var addSiteGroup: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("NO_SITE_GROUPS", systemImage: "folder.fill")
        } description: {
            Text("ADD_SITE_GROUP_TO_GET_STARTED")
        } actions: {
            Button("ADD_SITE_GROUP") {
                addSiteGroup()
            }
        }
    }

}

#Preview {
    NoSiteGroupsView(addSiteGroup: { })
}
