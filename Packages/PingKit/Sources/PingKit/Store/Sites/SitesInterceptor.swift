//
//  SitesInterceptor.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

func sitesInterceptor(
    state: SitesState,
    action: SitesAction,
    dependencies: SitesDependencies
) async -> SitesAction? {
    switch action {
    case .load:
        do {
            let sites = try await dependencies.sites()
            return .set(sites)
        } catch {
            return .set([])
        }

    case .store(let site):
        do {
            try await dependencies.add(site)
        } catch {
            fatalError("Failed saving site")
        }

        return .load

    case .remove(let site):
        do {
            try await dependencies.remove(site)
        } catch {
            fatalError("Failed deleting site")
        }

        return .load

    default:
        return nil
    }
}
