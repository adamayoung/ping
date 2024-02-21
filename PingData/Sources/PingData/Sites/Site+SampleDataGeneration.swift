//
//  Site+SampleDataGeneration.swift
//  PingData
//
//  Created by Adam Young on 16/02/2024.
//

import Foundation
import SwiftData

extension Site {

    static func generate() -> [Site] {
        let sites: [Site] = [
            .google,
            .gitHub,
            .twitter,
            .microsoft
        ]

        return sites
    }

}

public extension Site {

    static let google: Site = {
        Site(
            id: .googleSiteID,
            name: "Google",
            request: SiteStatusRequest(
                url: .google
            ),
            statuses: [
                SiteStatus(
                    statusCode: .failure("Request timed out."),
                    time: 10,
                    timestamp: Date(timeIntervalSince1970: 1699463000))
            ]
        )
    }()

    static let gitHub: Site = {
        Site(
            id: .gitHubSiteID,
            name: "GitHub",
            request: SiteStatusRequest(
                url: .gitHub
            ),
            statuses: [
                SiteStatus(
                    statusCode: .failure("Network connection error"),
                    time: 2,
                    timestamp: Date(timeIntervalSince1970: 1699453000)
                ),
                SiteStatus(statusCode: .success, time: 5, timestamp: Date(timeIntervalSince1970: 1699463000)),
                SiteStatus(statusCode: .success, time: 10, timestamp: Date(timeIntervalSince1970: 1699473000))
            ]
        )
    }()

    static let twitter: Site = {
        Site(
            id: .twitterSiteID,
            name: "Twitter",
            request: SiteStatusRequest(
                url: .twitter
            )
        )
    }()

    static let microsoft: Site = {
        Site(
            id: .microsoftSiteID,
            name: "Microsoft",
            request: SiteStatusRequest(
                url: .microsoft
            )
        )
    }()

}

public extension UUID {

    static var googleSiteID: UUID {
        UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!
    }

    static var gitHubSiteID: UUID {
        UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!
    }

    static var twitterSiteID: UUID {
        UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!
    }

    static var microsoftSiteID: UUID {
        UUID(uuidString: "DC9434E8-B761-4193-9E6C-C1D6360D24D2")!
    }

}

public extension URL {

    static var google: URL {
        URL(string: "https://www.google.com")!
    }

    static var gitHub: URL {
        URL(string: "https://github.com")!
    }

    static var twitter: URL {
        URL(string: "https://twitter.com")!
    }

    static var microsoft: URL {
        URL(string: "https://microsoft.com")!
    }

}
