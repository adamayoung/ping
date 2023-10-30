//
//  SiteStatus.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

@Model
final class SiteStatus {

    var id: UUID

    var site: Site

    var statusCode: SiteStatusCode

    var timestamp: Date

    init(
        id: UUID,
        site: Site,
        statusCode: SiteStatusCode,
        timestamp: Date = .now
    ) {
        self.id = id
        self.site = site
        self.statusCode = statusCode
        self.timestamp = timestamp
    }

}
