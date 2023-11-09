//
//  Site+Mapper.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

extension Site {

    convenience init(site: PingDomain.Site) {
        let request = SiteStatusRequest(request: site.request)

        self.init(
            id: site.id,
            name: site.name,
            request: request
        )
    }

}

extension PingDomain.Site {

    init?(site: Site) {
        guard let request = site.request else {
            return nil
        }

        let requestModel = PingDomain.SiteStatusRequest(request: request)

        self.init(
            id: site.id,
            name: site.name,
            request: requestModel
        )
    }

}
