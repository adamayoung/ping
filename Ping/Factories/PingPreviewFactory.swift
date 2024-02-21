//
//  PingPreviewFactory.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation
import PingData
import SwiftData

@MainActor
final class PingPreviewFactory: PingFactoryProvider {

//    let siteStatusCheckerService: SiteStatusCheckerService = {
//        SiteStatusCheckerService.preview(urlSession: urlSession, checkingSites: [.microsoftSiteID])
//    }()

    init() { }

}

extension PingPreviewFactory {

    private static let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        URLProtocolMock.responseConfigs = [
            URL.google: (
                HTTPURLResponse(url: URL.google, statusCode: 500, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.gitHub: (
                HTTPURLResponse(url: URL.google, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.twitter: (
                HTTPURLResponse(url: URL.twitter, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.microsoft: (
                HTTPURLResponse(url: URL.microsoft, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            )
        ]
        configuration.protocolClasses = [URLProtocolMock.self]

        return URLSession(configuration: configuration)
    }()

}
