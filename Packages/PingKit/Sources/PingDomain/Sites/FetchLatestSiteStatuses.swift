//
//  FetchLatestSiteStatuses.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public final class FetchLatestSiteStatuses: FetchLatestSiteStatusesUseCase {

    private let siteStatusDataSource: any SiteStatusDataSource

    public init(
        siteStatusDataSource: some SiteStatusDataSource
    ) {
        self.siteStatusDataSource = siteStatusDataSource
    }

    public func execute() async throws -> [Site.ID: SiteStatus] {
        let siteStatuses = try await siteStatusDataSource.fetchAllLatest()
        return siteStatuses
    }

}
