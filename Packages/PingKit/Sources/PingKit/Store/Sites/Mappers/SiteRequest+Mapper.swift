//
//  SiteRequest+Mapper.swift
//  PingKit
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

extension SiteStatusRequest {

    init(request: PingDomain.SiteStatusRequest) {
        let method = SiteStatusRequest.Method(method: request.method)

        self.init(
            url: request.url,
            method: method,
            timeout: request.timeout
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
