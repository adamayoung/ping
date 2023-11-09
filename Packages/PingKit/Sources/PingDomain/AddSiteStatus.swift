//
//  AddSiteStatus.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public final class AddSiteStatus: AddSiteStatusUseCase {

    private let siteStatusDataSource: any SiteStatusDataSource

    public init(siteStatusDataSource: some SiteStatusDataSource) {
        self.siteStatusDataSource = siteStatusDataSource
    }

    public func execute(_ siteStatus: SiteStatus, for siteID: Site.ID) async throws {
        try await siteStatusDataSource.save(siteStatus, for: siteID)
    }

}
