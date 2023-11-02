//
//  AddSiteSheetView.swift
//  Ping
//
//  Created by Adam Young on 01/11/2023.
//

import PingKit
import SwiftUI

struct AddSiteSheetView: View {

    @Environment(PingStore.self) private var store

    var body: some View {
        #if os(macOS)
        macOSAddSiteView
        #else
        iOSAddSiteView
        #endif
    }

    private var macOSAddSiteView: some View {
        AddSiteView()
            .padding()
            .frame(width: 300)
            .environment(store)
    }

    private var iOSAddSiteView: some View {
        NavigationView {
            AddSiteView()
                .environment(store)
        }
    }

}

#Preview {
    let store = PingStore.preview()

    return AddSiteSheetView()
        .environment(store)
}
