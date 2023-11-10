//
//  Site.swift
//  Ping
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

@Model
final class Site: Identifiable {

    var id: UUID = UUID()

    var name: String = ""

    var isActive: Bool = true

    @Relationship(deleteRule: .cascade, inverse: \SiteStatusRequest.site)
    var request: SiteStatusRequest?

    @Relationship(deleteRule: .cascade)
    var statuses: [SiteStatus]?

    var group: SiteGroup?

    var latestStatus: SiteStatus? {
        let sortedStatuses = statuses?.sorted(by: { $0.timestamp < $1.timestamp }) ?? []
        return sortedStatuses.last
    }

    init(
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
