//
//  PingApp.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import PingData
import SwiftData
import SwiftUI

@main
@MainActor
struct PingApp: App {

    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif

    var body: some Scene {
        WindowGroup {
            ContentView()
                .siteStatusCheckerService()
                .pingDataContainer()
        }
    }

}
