//
//  SiteStatus.swift
//  PingDomain
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation

public struct SiteStatus: Identifiable, Hashable, Equatable {

    public let id: UUID
    public let statusCode: SiteStatus.Code
    public let time: TimeInterval
    public let timestamp: Date

    public init(
        id: UUID = UUID(),
        statusCode: SiteStatus.Code,
        time: TimeInterval,
        timestamp: Date = .now
    ) {
        self.id = id
        self.statusCode = statusCode
        self.time = time
        self.timestamp = timestamp
    }

}

extension SiteStatus {

    public enum Code: Hashable, Equatable {

        case unknown
        case success
        case failure(SiteStatusError)

    }

}
