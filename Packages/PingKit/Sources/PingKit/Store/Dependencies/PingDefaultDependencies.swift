//
//  PingDefaultDependencies.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingData
import PingDomain

final class PingDefaultDependencies: PingDependencies {

    private let factory: any PingFactory

    init(factory: some PingFactory) {
        self.factory = factory
    }

}

extension PingDefaultDependencies: SitesDependencies {

    func sites() async -> [Site] {
        let useCase = factory.fetchSitesUseCase()
        let siteModels = (try? await useCase.execute()) ?? []
        let sites = siteModels.map(Site.init)
        return sites
    }

    func add(site: Site) async throws {
        let useCase = factory.addSiteUseCase()
        let siteModel = PingDomain.Site(site: site)
        try await useCase.execute(site: siteModel)
    }

    func remove(id: Site.ID) async throws {
        let useCase = factory.removeSiteUseCase()
        try await useCase.execute(id: id)
    }

    func latestSiteStatuses() async throws -> [Site.ID: SiteStatus] {
        let useCase = factory.fetchLatestSiteStatusesUseCase()
        let siteStatusesModel = try await useCase.execute()
        var siteStatuses = [Site.ID: SiteStatus]()
        for (siteID, siteStatus) in siteStatusesModel {
            siteStatuses[siteID] = SiteStatus(siteStatus: siteStatus)
        }

        return siteStatuses
    }

    func siteStatus(site: Site) async throws -> SiteStatus {
        let useCase = factory.checkSiteStatusUseCase()
        let siteModel = PingDomain.Site(site: site)
        let siteStatusModel = try await useCase.execute(site: siteModel)
        let siteStatus = SiteStatus(siteStatus: siteStatusModel)
        return siteStatus
    }

    func allSiteStatuses() async throws -> [Site.ID: SiteStatus] {
        let useCase = factory.checkAllSiteStatusesUseCase()
        let siteStatusesModel = try await useCase.execute()
        var siteStatuses = [Site.ID: SiteStatus]()
        for (siteID, siteStatus) in siteStatusesModel {
            siteStatuses[siteID] = SiteStatus(siteStatus: siteStatus)
        }

        return siteStatuses
    }

    func store(siteStatus: SiteStatus, for site: Site) async throws {
        let useCase = factory.storeSiteStatusUseCase()
        let siteStatus = PingDomain.SiteStatus(siteStatus: siteStatus, siteID: site.id)
        let site = PingDomain.Site(site: site)
        try await useCase.execute(siteStatus: siteStatus, for: site)
    }

}
