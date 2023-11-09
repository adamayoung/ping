//
//  Site+Mapper.swift
//  PingKit
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

extension Site {

    init(site: PingDomain.Site) {
        let request = SiteStatusRequest(request: site.request)

        self.init(
            id: site.id,
            name: site.name,
            request: request
        )
    }

}

extension PingDomain.Site {

    init(site: Site) {
        let request = PingDomain.SiteStatusRequest(request: site.request)

        self.init(
            id: site.id,
            name: site.name,
            request: request
        )
    }

}
