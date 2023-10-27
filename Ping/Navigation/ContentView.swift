//
//  ContentView.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
    #if os(macOS)
        Text("HELLO_WORLD")
//        NavigationSplitView {
//            Sidebar(selection: $selection)
//        } detail: {
//            NavigationStack {
//                DetailColumn(selection: $selection)
//            }
//        }
//        .frame(minWidth: 600, minHeight: 450)
    #else
        AppTabView()
    #endif
    }

}

#Preview {
    ContentView()
}
