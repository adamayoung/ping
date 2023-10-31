//
//  PingLiveDependencies.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingData
import PingDomain

final class PingLiveDependencies: PingDependencies {

    init(inMemoryStorage: Bool = false) {
        PingDataConfiguration.setInMemoryStorage(inMemoryStorage)
    }

}

extension PingLiveDependencies: SitesDependencies {

    func sites() async -> [Site] {
        let useCase = fetchSitesUseCase()
        let siteModels = (try? await useCase.execute()) ?? []
        let sites = siteModels.map(Site.init)
        return sites
    }

    func add(site: Site) async throws {
        let useCase = addSiteUseCase()
        let siteModel = PingDomain.Site(site: site)
        try await useCase.execute(site: siteModel)
    }

    func remove(id: Site.ID) async throws {
        let useCase = removeSiteUseCase()
        try await useCase.execute(id: id)
    }

    func latestSiteStatuses() async throws -> [Site.ID: SiteStatus] {
        let useCase = fetchLatestSiteStatusesUseCase()
        let siteStatusesModel = try await useCase.execute()
        var siteStatuses = [Site.ID: SiteStatus]()
        for (siteID, siteStatus) in siteStatusesModel {
            siteStatuses[siteID] = SiteStatus(siteStatus: siteStatus)
        }

        return siteStatuses
    }

    func siteStatus(site: Site) async throws -> SiteStatus {
        let useCase = checkSiteStatusUseCase()
        let siteModel = PingDomain.Site(site: site)
        let siteStatusModel = try await useCase.execute(site: siteModel)
        let siteStatus = SiteStatus(siteStatus: siteStatusModel)
        return siteStatus
    }

    func store(siteStatus: SiteStatus, for site: Site) async throws {
        let useCase = storeSiteStatusUseCase()
        let siteStatus = PingDomain.SiteStatus(siteStatus: siteStatus, siteID: site.id)
        let site = PingDomain.Site(site: site)
        try await useCase.execute(siteStatus: siteStatus, for: site)
    }

}

extension PingLiveDependencies {

    private func fetchSitesUseCase() -> some FetchSitesUseCase {
        FetchSites(siteDataSource: siteDataSource())
    }

    private func addSiteUseCase() -> some AddSiteUseCase {
        AddSite(siteDataSource: siteDataSource())
    }

    private func removeSiteUseCase() -> some RemoveSiteUseCase {
        RemoveSite(siteDataSource: siteDataSource())
    }

    private func fetchLatestSiteStatusesUseCase() -> some FetchLatestSiteStatusesUseCase {
        FetchLatestSiteStatuses(siteStatusDataSource: siteStatusDataSource())
    }

    private func checkSiteStatusUseCase() -> some CheckSiteStatusUseCase {
        CheckSiteStatus(siteStatusService: siteStatusService())
    }

    private func storeSiteStatusUseCase() -> some StoreSiteStatusUseCase {
        StoreSiteStatus(siteStatusDataSource: siteStatusDataSource())
    }

}

extension PingLiveDependencies {

    private func siteDataSource() -> some SiteDataSource {
        SiteSwiftDataDataSource()
    }

    private func siteStatusDataSource() -> some SiteStatusDataSource {
        SiteStatusSwiftDataDataSource()
    }

    private func siteStatusService() -> some SiteStatusService {
        SiteStatusURLSessionService(urlSession: .shared)
    }

}
