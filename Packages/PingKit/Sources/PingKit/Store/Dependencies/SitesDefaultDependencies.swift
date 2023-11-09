//
//  SitesDefaultDependencies.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingData
import PingDomain

final class SitesDefaultDependencies: SitesDependencies {

    private let factory: any PingFactory

    init(factory: some PingFactory) {
        self.factory = factory
    }

    func sites() async -> [Site] {
        let useCase = factory.allSitesUseCase()
        let siteModels = (try? await useCase.execute()) ?? []
        let sites = siteModels.map(Site.init)
        return sites
    }

    func add(_ site: Site) async throws {
        let useCase = factory.addSiteUseCase()
        let siteModel = PingDomain.Site(site: site)
        try await useCase.execute(siteModel)
    }

    func remove(_ site: Site) async throws {
        let useCase = factory.removeSiteUseCase()
        try await useCase.execute(site.id)
    }

}
