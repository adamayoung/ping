//
//  SIteRequestMethod+Mapper.swift
//  PingKit
//
//  Created by Adam Young on 03/11/2023.
//

import Foundation
import PingDomain

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
