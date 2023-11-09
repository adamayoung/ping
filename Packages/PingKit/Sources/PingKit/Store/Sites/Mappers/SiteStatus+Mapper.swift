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
            time: siteStatus.time,
            timestamp: siteStatus.timestamp
        )
    }

}

extension PingDomain.SiteStatus {

    init(siteStatus: SiteStatus) {
        let statusCode = PingDomain.SiteStatus.Code(siteStatusCode: siteStatus.statusCode)

        self.init(
            id: siteStatus.id,
            statusCode: statusCode,
            time: siteStatus.time,
            timestamp: siteStatus.timestamp
        )
    }

}
