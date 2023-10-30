//
//  SitesState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct SitesState: Equatable {

    public internal(set) var all: [Site]
    public internal(set) var statuses: [Site.ID: SiteStatus]

    public init(
        all: [Site] = [],
        statuses: [Site.ID: SiteStatus] = [:]
    ) {
        self.all = all
        self.statuses = statuses
    }

    public func status(for site: Site) -> SiteStatus {
        statuses[site.id, default: .unknown]
    }

}
