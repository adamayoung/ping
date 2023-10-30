//
//  SiteStatus.swift
//  PingDomain
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation

public struct SiteStatus: Identifiable, Equatable {

    public let id: UUID
    public let siteID: Site.ID
    public let statusCode: SiteStatusCode
    public let timestamp: Date

    public init(
        id: UUID,
        siteID: Site.ID,
        statusCode: SiteStatusCode,
        timestamp: Date
    ) {
        self.id = id
        self.siteID = siteID
        self.statusCode = statusCode
        self.timestamp = timestamp
    }

}
