//
//  SiteStatusesForSites.swift
//  PingDomain
//
//  Created by Adam Young on 02/11/2023.
//

import Foundation

public final class SiteStatusesForSites: SiteStatusesForSitesUseCase {

    private let siteStatusDataSource: any SiteStatusDataSource

    public init(siteStatusDataSource: some SiteStatusDataSource) {
        self.siteStatusDataSource = siteStatusDataSource
    }

    public func execute(for siteIDs: [Site.ID]) async throws -> [Site.ID: [SiteStatus]] {
        let siteStatuses = try await siteStatusDataSource.fetchAll(for: siteIDs)
        return siteStatuses
    }

}
