//
//  SitesAction.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public enum SitesAction {

    case fetch
    case set([Site])

    case add(Site)
    case remove(Site)

    case fetchLatestSiteStatuses
    case setSiteStatuses([Site.ID: SiteStatus])
    case setSiteStatus(Site, SiteStatus)

    case checkSiteStatus(Site)

}
