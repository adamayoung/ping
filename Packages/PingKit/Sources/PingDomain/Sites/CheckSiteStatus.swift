//
//  CheckSiteStatus.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public final class CheckSiteStatus: CheckSiteStatusUseCase {

    private let siteStatusService: any SiteStatusService

    public init(
        siteStatusService: some SiteStatusService
    ) {
        self.siteStatusService = siteStatusService
    }

    public func execute(site: Site) async throws -> SiteStatus {
        let status = await siteStatusService.check(site: site)
        return status
    }

}
