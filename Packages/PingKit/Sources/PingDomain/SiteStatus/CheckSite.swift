//
//  CheckSite.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public final class CheckSite: CheckSiteUseCase {

    private let siteStatusService: any SiteStatusService
    private let siteDataSource: any SiteDataSource

    public init(
        siteStatusService: some SiteStatusService,
        siteDataSource: some SiteDataSource
    ) {
        self.siteStatusService = siteStatusService
        self.siteDataSource = siteDataSource
    }

    public func execute(siteID: Site.ID) async throws -> SiteStatus {
        guard let site = try await siteDataSource.site(withID: siteID) else {
            return .unknown
        }

        let status = try await siteStatusService.check(site: site)
        return status
    }

}
