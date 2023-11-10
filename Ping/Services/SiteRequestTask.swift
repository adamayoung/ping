//
//  SiteRequestTask.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Foundation

struct SiteRequestTask: Sendable {

    let siteID: UUID
    let url: URL
    let method: String
    let timeout: TimeInterval

    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        urlRequest.timeoutInterval = timeout
        return urlRequest
    }

}

extension SiteRequestTask {

    init?(siteRequest: SiteStatusRequest?) {
        guard let siteRequest, let siteID = siteRequest.site?.id else {
            return nil
        }

        self.init(
            siteID: siteID,
            url: siteRequest.url,
            method: "GET",
            timeout: siteRequest.timeout
        )
    }

}
