//
//  ManageSiteGroupsSheetView.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import SwiftUI

struct ManageSiteGroupsSheetView: View {

    var body: some View {
        NavigationStack {
            ManageSiteGroupsView()
        }
        #if os(macOS)
        .frame(width: 500, height: 300)
        #endif
    }

}

#Preview {
    let modelContainer = PingFactory.shared.modelContainer

    return ManageSiteGroupsSheetView()
        .modelContainer(modelContainer)
}
