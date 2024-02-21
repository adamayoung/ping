//
//  PingLiveFactory.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation
import SwiftData

@MainActor
final class PingLiveFactory: PingFactoryProvider {

//    let siteStatusCheckerService: SiteStatusCheckerService = {
//        SiteStatusCheckerService(urlSession: urlSession)
//    }()

    init() { }

}

extension PingLiveFactory {

    private static let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        #if !os(macOS)
        configuration.multipathServiceType = .handover
        #endif

        return URLSession(configuration: configuration)
    }()

}
