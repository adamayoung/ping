//
//  SiteStatusesState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct SiteStatusesState: Equatable {

    public internal(set) var all: [Site.ID: [SiteStatus]]

    public init(
        all: [Site.ID: [SiteStatus]] = [:]
    ) {
        self.all = all
    }

    public func siteStatuses(for site: Site) -> [SiteStatus] {
        all[site.id, default: [SiteStatus(statusCode: .unknown, time: 0)]]
    }

    public func latestSiteStatus(for site: Site) -> SiteStatus {
        siteStatuses(for: site).last ?? SiteStatus(statusCode: .unknown, time: 0)
    }

}
