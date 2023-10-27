//
//  PingInterceptor.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

func pingInterceptor(
    state: PingState,
    action: PingAction,
    dependencies: PingDependencies
) async -> PingAction? {
    switch action {
    case .fetchSites:
        let sites = Site.previews
        return .setSites(sites)

    case .saveSite(let site):
        return .addSite(site)

    default:
        return nil
    }

}
