//
//  PingApp.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import SwiftData
import SwiftUI

@main
@MainActor
struct PingApp: App {

    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif

    private var sharedModelContainer = ModelContainer.ping
    private var siteStatusCheckerService = SiteStatusCheckerService()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environment(siteStatusCheckerService)
    }

}
