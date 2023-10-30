//
//  SitesState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct SitesState: Equatable {

    public internal(set) var all: [Site]
    public internal(set) var statuses: [Site.ID: SiteStatusCode]

    public init(
        all: [Site] = [],
        statuses: [Site.ID: SiteStatusCode] = [:]
    ) {
        self.all = all
        self.statuses = statuses
    }

    public func status(for site: Site) -> SiteStatusCode {
        statuses[site.id, default: .unknown]
    }

}
