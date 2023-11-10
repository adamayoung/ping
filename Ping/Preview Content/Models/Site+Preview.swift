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
            id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
            name: "Google",
            request: SiteStatusRequest(
                url: URL(string: "https://www.google.com")!
            ),
            statuses: [
                SiteStatus(statusCode: .failure("Failed"), time: 10, timestamp: Date(timeIntervalSince1970: 1699463000))
            ]
        )
    }()

    static let gitHubPreview: Site = {
        Site(
            id: UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!,
            name: "GitHub",
            request: SiteStatusRequest(
                url: URL(string: "https://github.com")!
            ),
            statuses: [
                SiteStatus(statusCode: .failure("Network connection error"), time: 2,
                           timestamp: Date(timeIntervalSince1970: 1699453000)),
                SiteStatus(statusCode: .success, time: 5, timestamp: Date(timeIntervalSince1970: 1699463000)),
                SiteStatus(statusCode: .success, time: 10, timestamp: Date(timeIntervalSince1970: 1699473000))
            ]
        )
    }()

    static let twitterPreview: Site = {
        Site(
            id: UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!,
            name: "Twitter",
            request: SiteStatusRequest(
                url: URL(string: "https://twitter.com")!
            )
        )
    }()

    static let microsoftPreview: Site = {
        Site(
            id: UUID(uuidString: "DC9434E8-B761-4193-9E6C-C1D6360D24D2")!,
            name: "Microsoft",
            request: SiteStatusRequest(
                url: URL(string: "https://microsoft.com")!
            )
        )
    }()

}
