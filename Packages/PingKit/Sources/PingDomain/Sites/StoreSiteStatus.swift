//
//  StoreSiteStatus.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public final class StoreSiteStatus: StoreSiteStatusUseCase {

    private let siteStatusDataSource: any SiteStatusDataSource

    public init(siteStatusDataSource: some SiteStatusDataSource) {
        self.siteStatusDataSource = siteStatusDataSource
    }

    public func execute(siteStatus: SiteStatus, for site: Site) async throws {
        try await siteStatusDataSource.save(siteStatus: siteStatus, for: site.id)
    }

}
