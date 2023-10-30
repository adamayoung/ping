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
        state.statuses[site.id] = .checking

    case .setSiteStatus(let site, let siteStatus):
        state.statuses[site.id] = siteStatus

    default:
        break
    }

    return state
}
