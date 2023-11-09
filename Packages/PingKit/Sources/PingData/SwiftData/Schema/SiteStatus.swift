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
    var statusCode: SiteStatus.Code
    var time: TimeInterval
    var timestamp: Date
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

    enum Code: Codable {
        case success
        case failure(String)
        case unknown
    }

}
