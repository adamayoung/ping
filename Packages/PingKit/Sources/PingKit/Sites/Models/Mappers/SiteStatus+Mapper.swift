//
//  SiteStatusCode+Mapper.swift
//
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation
import PingDomain

extension SiteStatus {

    init(siteStatus: PingDomain.SiteStatus) {
        let statusCode = SiteStatusCode(siteStatusCode: siteStatus.statusCode)

        self.init(
            id: siteStatus.id,
            statusCode: statusCode,
            timestamp: siteStatus.timestamp
        )
    }

}

extension PingDomain.SiteStatus {

    init(siteStatus: SiteStatus, siteID: Site.ID) {
        let statusCode = PingDomain.SiteStatusCode(siteStatusCode: siteStatus.statusCode)

        self.init(
            id: siteStatus.id,
            siteID: siteID,
            statusCode: statusCode,
            timestamp: siteStatus.timestamp
        )
    }

}
