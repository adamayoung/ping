//
//  SiteStatusesReducer.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

func siteStatusesReducer(state: SiteStatusesState, action: SiteStatusesAction) -> SiteStatusesState {
    var state = state

    switch action {
    case .set(let siteStatuses):
        state.all = siteStatuses

    case .setForSite(let siteStatuses, let siteID):
        state.all[siteID] = siteStatuses

    case .append(let siteStatuses):
        for (siteID, siteStatus) in siteStatuses {
            state.all[siteID, default: []].append(siteStatus)
        }

    case .appendForSite(let siteStatus, let siteID):
        state.all[siteID, default: []].append(siteStatus)

    default:
        break
    }

    return state
}
