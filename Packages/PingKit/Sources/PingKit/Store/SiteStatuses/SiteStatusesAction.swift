//
//  SiteStatusesAction.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public enum SiteStatusesAction {

    case load([Site.ID])
    case loadForSite(Site.ID)

    case checkSiteStatuses([Site])
    case checkSiteStatus(Site)

    case set([Site.ID: [SiteStatus]])
    case setForSite([SiteStatus], Site.ID)
    case append([Site.ID: SiteStatus])
    case appendForSite(SiteStatus, Site.ID)

    case store(SiteStatus, Site.ID)
    case storeForSites([Site.ID: SiteStatus])

}
