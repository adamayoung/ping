//
//  SiteStatus.swift
//  PingKit
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation

public struct SiteStatus: Identifiable, Equatable {

    public let id: UUID
    public let statusCode: SiteStatusCode
    public let timestamp: Date

    public init(
        id: UUID = UUID(),
        statusCode: SiteStatusCode,
        timestamp: Date = .now
    ) {
        self.id = id
        self.statusCode = statusCode
        self.timestamp = timestamp
    }

    func withStatusCode(_ statusCode: SiteStatusCode) -> SiteStatus {
        SiteStatus(
            id: id,
            statusCode: statusCode,
            timestamp: .now
        )
    }

}
