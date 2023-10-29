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

}

extension PingLiveDependencies {

    private func siteDataSource() -> some SiteDataSource {
        SiteSwiftDataDataSource()
    }

}