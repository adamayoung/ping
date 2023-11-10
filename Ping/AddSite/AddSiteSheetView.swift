//
//  AddSiteSheetView.swift
//  Ping
//
//  Created by Adam Young on 01/11/2023.
//

import SwiftData
import SwiftUI

struct AddSiteSheetView: View {

    var body: some View {
        #if os(macOS)
        macOSAddSiteView
        #else
        iOSAddSiteView
        #endif
    }

    @MainActor private var macOSAddSiteView: some View {
        NavigationStack {
            AddSiteView()
                .scrollDisabled(true)
        }
        .frame(width: 500, height: 300)
    }

    @MainActor private var iOSAddSiteView: some View {
        NavigationStack {
            AddSiteView()
        }
    }

}

#Preview {
    let modelContainer = PingFactory.shared.modelContainer

    return AddSiteSheetView()
        .modelContainer(modelContainer)
}
