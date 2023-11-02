//
//  CheckAllSiteStatuses.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public final class CheckAllSiteStatuses: CheckAllSiteStatusesUseCase {

    private let siteDataSource: any SiteDataSource
    private let siteStatusService: any SiteStatusService

    public init(
        siteDataSource: some SiteDataSource,
        siteStatusService: some SiteStatusService
    ) {
        self.siteDataSource = siteDataSource
        self.siteStatusService = siteStatusService
    }

    public func execute() async throws -> [Site.ID: SiteStatus] {
        try await withThrowingTaskGroup(of: SiteStatus.self, returning: [Site.ID: SiteStatus].self) { taskGroup in
            let sites = try await siteDataSource.fetchAll()

            for site in sites {
                taskGroup.addTask {
                    await self.siteStatusService.check(site: site)
                }
            }

            var siteStatuses = [Site.ID: SiteStatus]()
            while let siteStatus = try await taskGroup.next() {
                siteStatuses[siteStatus.siteID] = siteStatus
            }

            return siteStatuses
        }
    }

}
