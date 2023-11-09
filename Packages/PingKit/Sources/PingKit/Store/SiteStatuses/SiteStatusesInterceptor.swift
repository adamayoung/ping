//
//  SiteStatusesInterceptor.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

func siteStatusesInterceptor(
    state: SiteStatusesState,
    action: SiteStatusesAction,
    dependencies: SiteStatusesDependencies
) async -> SiteStatusesAction? {
    switch action {
    case .load(let siteIDs):
        let statuses: [Site.ID: [SiteStatus]]
        do {
            statuses = try await dependencies.siteStatuses(for: siteIDs)
        } catch {
            statuses = [:]
        }

        return .set(statuses)

    case .loadForSite(let siteID):
        let siteStatuses: [SiteStatus]
        do {
            siteStatuses = try await dependencies.siteStatuses(for: siteID)
        } catch {
            siteStatuses = []
        }

        return .setForSite(siteStatuses, siteID)

    case .checkSiteStatuses(let sites):
        let allSiteStatuses: [Site.ID: SiteStatus]
        do {
            allSiteStatuses = try await dependencies.checkSiteStatuses(for: sites)
        } catch {
            allSiteStatuses = [:]
        }

        return .storeForSites(allSiteStatuses)

    case .checkSiteStatus(let site):
        let siteStatus: SiteStatus
        do {
            siteStatus = try await dependencies.checkSiteStatus(for: site)
        } catch {
            return nil
        }

        return .store(siteStatus, site.id)

    case .store(let siteStatus, let siteID):
        do {
            try await dependencies.add(siteStatus, for: siteID)
        } catch {
            return nil
        }

        return .appendForSite(siteStatus, siteID)

    case .storeForSites(let siteStatuses):
        for (siteID, siteStatus) in siteStatuses {
            do {
                try await dependencies.add(siteStatus, for: siteID)
            } catch {
                return nil
            }
        }

        return .append(siteStatuses)

    default:
        return nil
    }

}
