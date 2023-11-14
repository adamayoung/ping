//
//  NoSitesView.swift
//  Ping
//
//  Created by Adam Young on 28/10/2023.
//

import SwiftUI

struct NoSitesView: View {

    var addSite: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("NO_SITES", systemImage: "globe")
            #if os(macOS)
                .labelStyle(.titleOnly)
            #endif
        } description: {
            Text("ADD_SITE_TO_GET_STARTED")
        } actions: {
            Button("ADD_SITE") {
                addSite()
            }
        }
    }

}

#Preview {
    NoSitesView(addSite: { })
}
