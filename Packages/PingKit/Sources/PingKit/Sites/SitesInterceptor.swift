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
    case .fetch:
        do {
            let sites = try await dependencies.sites()
            return .set(sites)
        } catch {
            return .set([])
        }

    case .add(let site):
        do {
            try await dependencies.add(site: site)
        } catch {
            fatalError("Failed saving site")
        }

        return .fetch

    case .remove(let site):
        do {
            try await dependencies.remove(id: site.id)
        } catch {
            fatalError("Failed deleting site")
        }

        return .fetch

    case .checkSiteStatus(let site):
        let siteStatus: SiteStatus
        do {
            siteStatus = try await dependencies.check(site: site)
        } catch {
            siteStatus = .unknown
            // fatalError("Failed deleting site")
        }

        return .setSiteStatus(site, siteStatus)

    default:
        return nil
    }

}
