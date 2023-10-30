//
//  SiteStatusCode+Mapper.swift
//  PingKit
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

extension SiteStatusCode {

    init(siteStatusCode: PingDomain.SiteStatusCode) {
        switch siteStatusCode {
        case .success:
            self = .success

        case .failure:
            self = .failure

        case .unknown:
            self = .unknown
        }
    }

}
