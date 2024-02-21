//
//  SiteStatusRequestTask.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Foundation

public struct SiteStatusRequestTask: Sendable {

    public let siteID: UUID
    public let url: URL
    public let method: String
    public let timeout: TimeInterval

    public init(siteID: UUID, url: URL, method: String, timeout: TimeInterval) {
        self.siteID = siteID
        self.url = url
        self.method = method
        self.timeout = timeout
    }

}

extension SiteStatusRequestTask {

    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        urlRequest.httpMethod = method
        urlRequest.timeoutInterval = timeout
        return urlRequest
    }

}
