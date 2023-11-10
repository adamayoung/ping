//
//  PingPreviewFactory.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation
import SwiftData

@MainActor
final class PingPreviewFactory: PingFactoryProvider {

    static let shared = PingPreviewFactory()

    let modelContainer: ModelContainer = {
        .preview
    }()

    let siteStatusCheckerService: SiteStatusCheckerService = {
        SiteStatusCheckerService.preview(urlSession: urlSession, checkingSites: [.microsoftSiteIDPreview])
    }()

    private init() { }

}

extension PingPreviewFactory {

    private static let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        URLProtocolMock.responseConfigs = [
            URL.googleURLPreview: (
                HTTPURLResponse(url: URL.googleURLPreview, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.gitHubURLPreview: (
                HTTPURLResponse(url: URL.googleURLPreview, statusCode: 500, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.twitterURLPreview: (
                HTTPURLResponse(url: URL.twitterURLPreview, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.microsoftURLPreview: (
                HTTPURLResponse(url: URL.microsoftURLPreview, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            )
        ]
        configuration.protocolClasses = [URLProtocolMock.self]

        return URLSession(configuration: configuration)
    }()

}
