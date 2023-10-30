//
//  SiteStatus+Mapper.swift
//  PingKit
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

extension SiteStatus {

    init(siteStatus: PingDomain.SiteStatus) {
        switch siteStatus {
        case .success:
            self = .success

        case .failure:
            self = .failure

        case .unknown:
            self = .unknown
        }
    }

}
