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

    var url: URL

    @Relationship(deleteRule: .cascade, inverse: \SiteStatus.site)
    var statuses: [SiteStatus]

    init(
        id: UUID = UUID(),
        name: String,
        url: URL,
        statuses: [SiteStatus] = []
    ) {
        self.id = id
        self.name = name
        self.url = url
        self.statuses = statuses
    }

}
