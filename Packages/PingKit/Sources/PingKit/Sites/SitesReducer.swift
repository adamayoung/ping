//
//  SitesReducer.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

func sitesReducer(state: SitesState, action: SitesAction) -> SitesState {
    var state = state

    switch action {
    case .set(let sites):
        state.all = sites

    case .checkSiteStatus(let site):
        let currentStatus = state.siteStatuses[site.id]?.withStatusCode(.checking) ?? SiteStatus(statusCode: .checking)
        state.siteStatuses[site.id] = currentStatus

    case .setSiteStatuses(let siteStatuses):
        state.siteStatuses = siteStatuses

    case .setSiteStatus(let site, let siteStatuses):
        state.siteStatuses[site.id] = siteStatuses

    default:
        break
    }

    return state
}
