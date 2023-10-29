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

    case .remove(let site):
        var sites = state.all
        sites.removeAll(where: { $0.id == site.id })
        state.all = sites

    default:
        break
    }

    return state
}
