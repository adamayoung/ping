//
//  SiteStatus+Mapper.swift
//  PingData
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation
import PingDomain

extension SiteStatus {

    convenience init(siteStatus: PingDomain.SiteStatus) {
        let statusCode = SiteStatusCode(siteStatusCode: siteStatus.statusCode)

        self.init(
            id: siteStatus.id,
            statusCode: statusCode,
            timestamp: siteStatus.timestamp
        )
    }

}

extension PingDomain.SiteStatus {

    init?(siteStatus: SiteStatus) {
        guard let siteID = siteStatus.site?.id else {
            return nil
        }

        let statusCode = PingDomain.SiteStatusCode(siteStatusCode: siteStatus.statusCode)

        self.init(
            id: siteStatus.id,
            siteID: siteID,
            statusCode: statusCode,
            timestamp: siteStatus.timestamp
        )
    }

}
