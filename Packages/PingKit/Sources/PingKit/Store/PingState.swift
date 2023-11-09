//
//  PingState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct PingState {

    public internal(set) var sites: SitesState
    public internal(set) var siteStatuses: SiteStatusesState

    public init(
        sites: SitesState = SitesState(),
        siteStatuses: SiteStatusesState = SiteStatusesState()
    ) {
        self.sites = sites
        self.siteStatuses = siteStatuses
    }

}
