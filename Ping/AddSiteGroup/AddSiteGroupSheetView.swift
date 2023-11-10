//
//  AddSiteGroupSheetView.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import SwiftUI

struct AddSiteGroupSheetView: View {

    var body: some View {
        #if os(macOS)
        macOSAddSiteGroupView
        #else
        iOSAddSiteGroupView
        #endif
    }

    @MainActor private var macOSAddSiteGroupView: some View {
        NavigationStack {
            AddSiteGroupView()
                .scrollDisabled(true)
        }
        .frame(width: 500, height: 300)
    }

    @MainActor private var iOSAddSiteGroupView: some View {
        NavigationStack {
            AddSiteGroupView()
        }
    }

}

#Preview {
    AddSiteGroupSheetView()
}
