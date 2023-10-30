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

    fileprivate static var app: PingStore {
        if Self.isUITesting {
            return PingStore.test
        }

        return PingStore()
    }

    private static var isUITesting: Bool {
        CommandLine.arguments.contains("-uitest")
    }

}
