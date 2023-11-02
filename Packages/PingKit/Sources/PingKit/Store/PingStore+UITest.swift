//
//  PingStore+UITest.swift
//  PingKit
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

extension PingStore {

    public static func uiTest() -> PingStore {
        let store = PingStore(
            dependencies: PingDefaultDependencies(
                factory: PingDefaultFactory(
                    inMemoryStorage: true,
                    urlSession: .shared
                )
            )
        )

        Task {
            await seed(store: store)
        }

        return store
    }

}

extension PingStore {

    private static func seed(store: PingStore) async {
        let googleSite = Site(
            id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
            name: "Google",
            url: URL(string: "https://www.google.com")!
        )
        let googleSiteStatus = SiteStatus(statusCode: .success, timestamp: Date(timeIntervalSince1970: 1698784047))

        let gitHubSite = Site(
            id: UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!,
            name: "GitHub",
            url: URL(string: "https://github.com")!
        )
        let gitHubSiteStatus = SiteStatus(statusCode: .success, timestamp: Date(timeIntervalSince1970: 1698784047))

        let twitterSite = Site(
            id: UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!,
            name: "Twitter",
            url: URL(string: "https://twitter.com")!
        )
        let twitterSiteStatus = SiteStatus(
            statusCode: .failure(SiteStatusError(errorDescription: "Failed")),
            timestamp: Date(timeIntervalSince1970: 1698784047)
        )

        let microsoftSite = Site(
            id: UUID(uuidString: "DC9434E8-B761-4193-9E6C-C1D6360D24D2")!,
            name: "Microsoft",
            url: URL(string: "https://microsoft.com")!
        )
        let microsoftSiteStatus = SiteStatus(statusCode: .unknown, timestamp: Date(timeIntervalSince1970: 1698784047))

        let actions: [PingAction] = [
            .sites(.add(googleSite)),
            .sites(.setSiteStatus(googleSite, googleSiteStatus)),
            .sites(.add(gitHubSite)),
            .sites(.setSiteStatus(gitHubSite, gitHubSiteStatus)),
            .sites(.add(twitterSite)),
            .sites(.setSiteStatus(twitterSite, twitterSiteStatus)),
            .sites(.add(microsoftSite)),
            .sites(.setSiteStatus(microsoftSite, microsoftSiteStatus))
        ]

        for action in actions {
            await store.send(action)
        }
    }

}