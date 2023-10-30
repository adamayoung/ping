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

    var statusCode: SiteStatusCode

    @Relationship(deleteRule: .cascade, inverse: \Site.statuses)
    var site: Site

    var timestamp: Date

    init(
        id: UUID,
        statusCode: SiteStatusCode,
        site: Site,
        timestamp: Date = .now
    ) {
        self.id = id
        self.statusCode = statusCode
        self.site = site
        self.timestamp = timestamp
    }

}

extension SiteStatus {

    enum SiteStatusCode: Codable {
        case unknown
        case success
        case failure
    }

}
