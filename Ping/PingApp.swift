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

    @State private var store = PingStore.app

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }

}

extension PingStore {

    static var app: PingStore {
        if CommandLine.arguments.contains("-uitest") {
            return PingStore.test
        }

        return PingStore()
    }

}
