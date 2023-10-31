//
//  SitesState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct SitesState: Equatable {

    public internal(set) var all: [Site]
    public internal(set) var siteStatuses: [Site.ID: SiteStatus]

    public init(
        all: [Site] = [],
        siteStatuses: [Site.ID: SiteStatus] = [:]
    ) {
        self.all = all
        self.siteStatuses = siteStatuses
    }

    public func siteStatus(for site: Site) -> SiteStatus {
        siteStatuses[site.id, default: SiteStatus(statusCode: .unknown)]
    }

}
