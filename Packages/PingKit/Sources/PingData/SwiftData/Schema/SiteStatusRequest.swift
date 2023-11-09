//
//  SiteStatusRequest.swift
//  PingData
//
//  Created by Adam Young on 02/11/2023.
//

import Foundation
import SwiftData

@Model
final class SiteStatusRequest {

    var url: URL
    var method: Method
    var timeout: TimeInterval
    var site: Site?

    init(
        url: URL,
        method: SiteStatusRequest.Method = .get,
        timeout: TimeInterval = 5,
        site: Site? = nil
    ) {
        self.url = url
        self.method = method
        self.timeout = timeout
        self.site = site
    }

}

extension SiteStatusRequest {

    public enum Method: Codable {

        case get

    }

}
