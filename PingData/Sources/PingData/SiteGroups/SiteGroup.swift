//
//  SiteGroup.swift
//  PingData
//
//  Created by Adam Young on 16/02/2024.
//

import Foundation
import SwiftData

@Model
public final class SiteGroup: Identifiable {

    public private(set) var id: UUID = UUID()

    public var name: String = ""

    @Relationship(deleteRule: .nullify, inverse: \Site.group)
    public var sites: [Site]?

    public init(
        id: UUID = UUID(),
        name: String,
        sites: [Site] = []
    ) {
        self.id = id
        self.name = name
        self.sites = sites
    }

}
