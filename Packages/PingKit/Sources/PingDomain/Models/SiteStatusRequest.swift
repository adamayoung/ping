//
//  SiteCheckRequest.swift
//  PingDomain
//
//  Created by Adam Young on 02/11/2023.
//

import Foundation

public struct SiteStatusRequest: Equatable, Hashable {

    public let url: URL
    public let method: Method
    public let timeout: TimeInterval

    public init(
        url: URL,
        method: SiteStatusRequest.Method = .get,
        timeout: TimeInterval = 5
    ) {
        self.url = url
        self.method = method
        self.timeout = timeout
    }

}

extension SiteStatusRequest {

    public enum Method {

        case get

    }

}
