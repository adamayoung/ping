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

    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif

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
        if CommandLine.isUITesting {
            return PingStore.uiTest()
        }

        return PingStore()
    }

}
