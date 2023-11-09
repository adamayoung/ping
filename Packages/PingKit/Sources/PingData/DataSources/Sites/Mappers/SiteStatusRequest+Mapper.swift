//
//  SiteStatusRequest+Mapper.swift
//  PingData
//
//  Created by Adam Young on 03/11/2023.
//

import Foundation
import PingDomain

extension SiteStatusRequest {

    convenience init(request: PingDomain.SiteStatusRequest) {
        let method = SiteStatusRequest.Method(method: request.method)

        self.init(
            url: request.url,
            method: method,
            timeout: request.timeout,
            site: nil
        )
    }

}

extension PingDomain.SiteStatusRequest {

    init(request: SiteStatusRequest) {
        let method = PingDomain.SiteStatusRequest.Method(method: request.method)

        self.init(
            url: request.url,
            method: method,
            timeout: request.timeout
        )
    }

}

extension SiteStatusRequest.Method {

    init(method: PingDomain.SiteStatusRequest.Method) {
        switch method {
        case .get:
            self = .get
        }
    }

}

extension PingDomain.SiteStatusRequest.Method {

    init(method: SiteStatusRequest.Method) {
        switch method {
        case .get:
            self = .get
        }
    }

}
