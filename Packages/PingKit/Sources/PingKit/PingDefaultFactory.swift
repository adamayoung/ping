//
//  PingDefaultFactory.swift
//  PingKit
//
//  Created by Adam Young on 01/11/2023.
//

import Foundation
import PingData
import PingDomain

final class PingDefaultFactory: PingFactory {

    private let inMemoryStorage: Bool
    private let urlSession: URLSession

    init(inMemoryStorage: Bool, urlSession: URLSession) {
        self.inMemoryStorage = inMemoryStorage
        self.urlSession = urlSession
    }

    // MARK: - Sites

    func allSitesUseCase() -> any AllSitesUseCase {
        AllSites(siteDataSource: siteDataSource())
    }

    func addSiteUseCase() -> any AddSiteUseCase {
        AddSite(siteDataSource: siteDataSource())
    }

    func removeSiteUseCase() -> any RemoveSiteUseCase {
        RemoveSite(siteDataSource: siteDataSource())
    }

    // MARK: - Site Statuses

    func siteStatusesForSitesUseCase() -> any SiteStatusesForSitesUseCase {
        SiteStatusesForSites(siteStatusDataSource: siteStatusDataSource())
    }

    func siteStatusesForSiteUseCase() -> any SiteStatusesForSiteUseCase {
        SiteStatusesForSite(siteStatusDataSource: siteStatusDataSource())
    }

    func checkSiteStatusForSiteUseCase() -> any CheckSiteStatusForSiteUseCase {
        CheckSiteStatusForSite(siteStatusService: siteStatusService())
    }

    func checkSiteStatusForSitesUseCase() -> any CheckSiteStatusForSitesUseCase {
        CheckSiteStatusForSites(siteStatusService: siteStatusService())
    }

    func addSiteStatusUseCase() -> any AddSiteStatusUseCase {
        AddSiteStatus(siteStatusDataSource: siteStatusDataSource())
    }

}

extension PingDefaultFactory {

    private func siteDataSource() -> some SiteDataSource {
        SiteSwiftDataDataSource(inMemory: inMemoryStorage)
    }

    private func siteStatusDataSource() -> some SiteStatusDataSource {
        SiteStatusSwiftDataDataSource(inMemory: inMemoryStorage)
    }

    private func siteStatusService() -> some SiteStatusService {
        SiteStatusURLSessionService(urlSession: urlSession)
    }

}
