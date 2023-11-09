//
//  CheckSiteStatusForSites.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public final class CheckSiteStatusForSites: CheckSiteStatusForSitesUseCase {

    private let siteStatusService: any SiteStatusService

    public init(siteStatusService: some SiteStatusService) {
        self.siteStatusService = siteStatusService
    }

    public func execute(for sites: [Site]) async throws -> [Site.ID: SiteStatus] {
        try await withThrowingTaskGroup(of: (Site.ID, SiteStatus).self,
                                        returning: [Site.ID: SiteStatus].self) { taskGroup in
            for site in sites {
                taskGroup.addTask {
                    await (site.id, self.siteStatusService.siteStatus(using: site.request))
                }
            }

            var siteStatuses = [Site.ID: SiteStatus]()
            while let (siteID, siteStatus) = try await taskGroup.next() {
                siteStatuses[siteID] = siteStatus
            }

            return siteStatuses
        }
    }

}
