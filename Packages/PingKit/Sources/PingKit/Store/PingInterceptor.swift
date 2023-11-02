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
    case .sites(let sitesAction):
        let newAction = await sitesInterceptor(state: state.sites, action: sitesAction, dependencies: dependencies)

        guard let action = newAction else {
            return nil
        }

        return .sites(action)
    }

}
