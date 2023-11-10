//
//  Site+Preview.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Foundation

extension Site {

    static var previews: [Site] {
        [
            .googlePreview,
            .twitterPreview,
            .gitHubPreview,
            .microsoftPreview
        ]
    }

    static let googlePreview: Site = {
        Site(
            id: UUID.googleSiteIDPreview,
            name: "Google",
            request: SiteStatusRequest(
                url: URL.googleURLPreview
            ),
            statuses: [
                SiteStatus(
                    statusCode: .failure("Request timed out."),
                    time: 10,
                    timestamp: Date(timeIntervalSince1970: 1699463000))
            ]
        )
    }()

    static let gitHubPreview: Site = {
        Site(
            id: UUID.gitHubSiteIDPreview,
            name: "GitHub",
            request: SiteStatusRequest(
                url: URL.gitHubURLPreview
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

    static let twitterPreview: Site = {
        Site(
            id: UUID.twitterSiteIDPreview,
            name: "Twitter",
            request: SiteStatusRequest(
                url: URL.twitterURLPreview
            )
        )
    }()

    static let microsoftPreview: Site = {
        Site(
            id: UUID.microsoftSiteIDPreview,
            name: "Microsoft",
            request: SiteStatusRequest(
                url: URL.microsoftURLPreview
            )
        )
    }()

}

extension UUID {

    static var googleSiteIDPreview: UUID {
        UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!
    }

    static var gitHubSiteIDPreview: UUID {
        UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!
    }

    static var twitterSiteIDPreview: UUID {
        UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!
    }

    static var microsoftSiteIDPreview: UUID {
        UUID(uuidString: "DC9434E8-B761-4193-9E6C-C1D6360D24D2")!
    }

}

extension URL {

    static var googleURLPreview: URL {
        URL(string: "https://www.google.com")!
    }

    static var gitHubURLPreview: URL {
        URL(string: "https://github.com")!
    }

    static var twitterURLPreview: URL {
        URL(string: "https://twitter.com")!
    }

    static var microsoftURLPreview: URL {
        URL(string: "https://microsoft.com")!
    }

}
