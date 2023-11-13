//
//  SiteStatusRequestTask.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Foundation

struct SiteStatusRequestTask: Sendable {

    let siteID: UUID
    let url: URL
    let method: String
    let timeout: TimeInterval

}

extension SiteStatusRequestTask {

    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        urlRequest.httpMethod = method
        urlRequest.timeoutInterval = timeout
        return urlRequest
    }

}
