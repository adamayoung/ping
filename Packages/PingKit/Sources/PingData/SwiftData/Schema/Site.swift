//
//  Site.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

@Model
final class Site {

    var id: UUID

    var name: String

    var isActive: Bool

    @Relationship(deleteRule: .cascade, inverse: \SiteStatusRequest.site)
    var request: SiteStatusRequest?

    @Relationship(deleteRule: .cascade, inverse: \SiteStatus.site)
    var statuses: [SiteStatus]

    init(
        id: UUID = UUID(),
        name: String,
        isActive: Bool = true,
        request: SiteStatusRequest? = nil,
        statuses: [SiteStatus] = []
    ) {
        self.id = id
        self.name = name
        self.isActive = isActive
        self.request = request
        self.statuses = statuses
    }

}
