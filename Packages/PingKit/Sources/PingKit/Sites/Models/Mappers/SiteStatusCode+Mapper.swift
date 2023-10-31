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

        case .failure(let error):
            let error = SiteStatusError(error: error)
            self = .failure(error)

        case .unknown:
            self = .unknown
        }
    }

}

extension PingDomain.SiteStatusCode {

    init(siteStatusCode: SiteStatusCode) {
        switch siteStatusCode {
        case .success:
            self = .success

        case .failure(let error):
            let error = PingDomain.SiteStatusError(error: error)
            self = .failure(error)

        case .unknown:
            self = .unknown

        default:
            self = .unknown
        }
    }

}
