//
//  SiteStatus.swift
//  Ping
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

@Model
final class SiteStatus: Identifiable {

    var id: UUID = UUID()
    var statusCode: SiteStatus.Code = SiteStatus.Code.unknown
    var time: TimeInterval = 0
    var timestamp: Date = Date.now

    @Relationship(inverse: \Site.statuses)
    var site: Site?

    init(
        id: UUID = UUID(),
        statusCode: SiteStatus.Code,
        time: TimeInterval,
        timestamp: Date = .now,
        site: Site? = nil
    ) {
        self.id = id
        self.statusCode = statusCode
        self.time = time
        self.timestamp = timestamp
        self.site = site
    }

}

extension SiteStatus {

    enum Code: Equatable, Codable {
        case success
        case failure(String)
        case unknown

        static var `default`: Code {
            .unknown
        }
    }

}
