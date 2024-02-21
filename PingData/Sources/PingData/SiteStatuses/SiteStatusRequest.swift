//
//  File.swift
//  
//
//  Created by Adam Young on 16/02/2024.
//

import Foundation
import SwiftData

@Model
public final class SiteStatusRequest {

    public var url: URL = URL(string: "https://www.example.com")!
    public var method: Method = SiteStatusRequest.Method.get
    public var timeout: TimeInterval = 5

    @Relationship(inverse: \SiteStatus.site)
    public var site: Site?

    public init(
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
