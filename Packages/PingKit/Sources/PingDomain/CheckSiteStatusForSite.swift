//
//  CheckSiteStatusForSite.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public final class CheckSiteStatusForSite: CheckSiteStatusForSiteUseCase {

    private let siteStatusService: any SiteStatusService

    public init(siteStatusService: some SiteStatusService) {
        self.siteStatusService = siteStatusService
    }

    public func execute(for site: Site) async throws -> SiteStatus {
        let siteStatus = await siteStatusService.siteStatus(using: site.request)
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return siteStatus
    }

}
