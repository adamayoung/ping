//
//  SiteGroup.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation
import SwiftData

@Model
final class SiteGroup: Identifiable {

    private(set) var id: UUID = UUID()

    var name: String = ""

    @Relationship(deleteRule: .nullify, inverse: \Site.group)
    var sites: [Site]?

    init(
        id: UUID = UUID(),
        name: String,
        sites: [Site] = []
    ) {
        self.id = id
        self.name = name
        self.sites = sites
    }

}
