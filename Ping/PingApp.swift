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

    private let sharedModelContainer = PingFactory.shared.modelContainer
    private let siteStatusCheckerService = PingFactory.shared.siteStatusCheckerService

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(siteStatusCheckerService.siteStatusPublisher) { statusResult in
                    addStatusResult(statusResult)
                }
        }
        .modelContainer(sharedModelContainer)
        .environment(siteStatusCheckerService)
    }

}

extension PingApp {

    private func addStatusResult(_ statusResult: SiteStatusResult) {
        let siteID = statusResult.siteID
        var fetchDescriptor = FetchDescriptor<Site>(predicate: #Predicate { $0.id == siteID })
        fetchDescriptor.fetchLimit = 1

        guard let site = try? sharedModelContainer.mainContext.fetch(fetchDescriptor).first else {
            return
        }

        let status = SiteStatus(statusCode: statusResult.siteStatusCode, time: statusResult.time)
        withAnimation {
            if site.statuses == nil {
                site.statuses = []
            }

            site.statuses?.append(status)
        }

        do {
            try sharedModelContainer.mainContext.save()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

}
