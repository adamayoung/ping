//
//  PingApp.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import PingKit
import SwiftUI

@main
struct PingApp: App {

    @State private var store = PingStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }

}
