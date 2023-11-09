//
//  SiteStatusesDefaultDependencies.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingData
import PingDomain

final class SiteStatusesDefaultDependencies: SiteStatusesDependencies {

    private let factory: any PingFactory

    init(factory: some PingFactory) {
        self.factory = factory
    }

    func siteStatuses(for siteIDs: [Site.ID]) async throws -> [Site.ID: [SiteStatus]] {
        let useCase = factory.siteStatusesForSitesUseCase()
        let allSiteStatusModels = try await useCase.execute(for: siteIDs)

        var siteStatuses = [Site.ID: [SiteStatus]]()
        for (siteID, siteStatusModels) in allSiteStatusModels {
            siteStatuses[siteID] = siteStatusModels
                .map(SiteStatus.init)
        }

        return siteStatuses
    }

    func siteStatuses(for siteID: Site.ID) async throws -> [SiteStatus] {
        let useCase = factory.siteStatusesForSiteUseCase()
        let siteStatusModels = try await useCase.execute(for: siteID)

        let siteStatuses = siteStatusModels
            .map(SiteStatus.init)
        return siteStatuses
    }

    func checkSiteStatuses(for sites: [Site]) async throws -> [Site.ID: SiteStatus] {
        let useCase = factory.checkSiteStatusForSitesUseCase()
        let siteModels = sites.map(PingDomain.Site.init)
        let allSiteStatusModels = try await useCase.execute(for: siteModels)

        var siteStatuses = [Site.ID: SiteStatus]()
        for (siteID, siteStatusModel) in allSiteStatusModels {
            siteStatuses[siteID] = SiteStatus(siteStatus: siteStatusModel)
        }

        return siteStatuses
    }

    func checkSiteStatus(for site: Site) async throws -> SiteStatus {
        let useCase = factory.checkSiteStatusForSiteUseCase()
        let siteModel = PingDomain.Site(site: site)
        let siteStatusModel = try await useCase.execute(for: siteModel)
        let siteStatus = SiteStatus(siteStatus: siteStatusModel)
        return siteStatus
    }

    func add(_ siteStatus: SiteStatus, for siteID: Site.ID) async throws {
        let useCase = factory.addSiteStatusUseCase()
        let siteStatusModel = PingDomain.SiteStatus(siteStatus: siteStatus)
        try await useCase.execute(siteStatusModel, for: siteID)
    }

}
