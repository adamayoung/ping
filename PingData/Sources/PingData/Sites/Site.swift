//
//  Site.swift
//  PingData
//
//  Created by Adam Young on 16/02/2024.
//

import Foundation
import SwiftData

@Model
public final class Site: Identifiable {

    public var id: UUID = UUID()

    public var name: String = ""

    public var isActive: Bool = true

    @Relationship(deleteRule: .cascade, inverse: \SiteStatusRequest.site)
    public var request: SiteStatusRequest?

    @Relationship(deleteRule: .cascade)
    public var statuses: [SiteStatus]?

    public var group: SiteGroup?

    public var latestStatus: SiteStatus? {
        let sortedStatuses = statuses?.sorted(by: { $0.timestamp < $1.timestamp }) ?? []
        return sortedStatuses.last
    }

    public init(
        id: UUID = UUID(),
        name: String,
        isActive: Bool = true,
        request: SiteStatusRequest? = nil,
        statuses: [SiteStatus] = [],
        group: SiteGroup? = nil
    ) {
        self.id = id
        self.name = name
        self.isActive = isActive
        self.request = request
        self.statuses = statuses
        self.group = group
    }

}
