//
//  SiteStatusRequest.swift
//  Ping
//
//  Created by Adam Young on 02/11/2023.
//

import Foundation
import SwiftData

@Model
final class SiteStatusRequest {

    var url: URL = URL(string: "https://www.example.com")!
    var method: Method = SiteStatusRequest.Method.get
    var timeout: TimeInterval = 5

    @Relationship(inverse: \SiteStatus.site)
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
