//
//  SiteStatusCode+Mapper.swift
//  PingData
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation
import PingDomain

extension SiteStatusCode {

    init(siteStatusCode: PingDomain.SiteStatusCode) {
        switch siteStatusCode {
        case .unknown:
            self = .unknown

        case .success:
            self = .success

        case .failure:
            self = .failure
        }
    }

}

extension PingDomain.SiteStatusCode {

    init(siteStatusCode: SiteStatusCode) {
        switch siteStatusCode {
        case .unknown:
            self = .unknown

        case .success:
            self = .success

        case .failure:
            self = .failure
        }
    }

}
