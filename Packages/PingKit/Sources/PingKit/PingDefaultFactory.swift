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

    func fetchSitesUseCase() -> any FetchSitesUseCase {
        FetchSites(siteDataSource: siteDataSource())
    }

    func addSiteUseCase() -> any AddSiteUseCase {
        AddSite(siteDataSource: siteDataSource())
    }

    func removeSiteUseCase() -> any RemoveSiteUseCase {
        RemoveSite(siteDataSource: siteDataSource())
    }

    func fetchLatestSiteStatusesUseCase() -> any FetchLatestSiteStatusesUseCase {
        FetchLatestSiteStatuses(siteStatusDataSource: siteStatusDataSource())
    }

    func checkSiteStatusUseCase() -> any CheckSiteStatusUseCase {
        CheckSiteStatus(siteStatusService: siteStatusService())
    }

    func checkAllSiteStatusesUseCase() -> any CheckAllSiteStatusesUseCase {
        CheckAllSiteStatuses(siteDataSource: siteDataSource(), siteStatusService: siteStatusService())
    }

    func storeSiteStatusUseCase() -> any StoreSiteStatusUseCase {
        StoreSiteStatus(siteStatusDataSource: siteStatusDataSource())
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
