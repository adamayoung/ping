//
//  File.swift
//  
//
//  Created by Adam Young on 16/02/2024.
//

import Foundation
import SwiftData

@Model
public final class SiteStatus: Identifiable {

    public var id: UUID = UUID()
    public var statusCode: SiteStatus.Code = SiteStatus.Code.unknown
    public var time: TimeInterval = 0
    public var timestamp: Date = Date.now
    @Relationship(inverse: \Site.statuses)
    public var site: Site?

    public var formattedTimestamp: String {
        timestamp.formatted(date: .numeric, time: .shortened)
    }

    public init(
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

    public enum Code: Equatable, Codable {
        case success
        case failure(String)
        case unknown

        public static var `default`: Code {
            .unknown
        }
    }

}
