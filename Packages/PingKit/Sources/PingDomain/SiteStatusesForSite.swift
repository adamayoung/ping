//
//  SiteStatusesForSite.swift
//  PingDomain
//
//  Created by Adam Young on 02/11/2023.
//

import Foundation

public final class SiteStatusesForSite: SiteStatusesForSiteUseCase {

    private let siteStatusDataSource: any SiteStatusDataSource

    public init(siteStatusDataSource: some SiteStatusDataSource) {
        self.siteStatusDataSource = siteStatusDataSource
    }

    public func execute(for siteID: Site.ID) async throws -> [SiteStatus] {
        let siteStatuses = try await siteStatusDataSource.fetchAll(for: siteID)
        return siteStatuses
    }

}
