//
//  SiteStatus+Mapper.swift
//  PingData
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation
import PingDomain

extension SiteStatus {

    convenience init(siteStatus: PingDomain.SiteStatus, site: Site) {
        let statusCode = SiteStatusCode(siteStatusCode: siteStatus.statusCode)

        self.init(
            id: siteStatus.id,
            site: site,
            statusCode: statusCode,
            timestamp: siteStatus.timestamp
        )
    }

}

extension PingDomain.SiteStatus {

    init(siteStatus: SiteStatus) {
        let statusCode = PingDomain.SiteStatusCode(siteStatusCode: siteStatus.statusCode)

        self.init(
            id: siteStatus.id,
            siteID: siteStatus.site.id,
            statusCode: statusCode,
            timestamp: siteStatus.timestamp
        )
    }

}
