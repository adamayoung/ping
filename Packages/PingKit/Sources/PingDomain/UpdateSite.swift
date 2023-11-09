//
//  UpdateSite.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public final class UpdateSite: UpdateSiteUseCase {

    private let siteDataSource: any SiteDataSource

    public init(siteDataSource: some SiteDataSource) {
        self.siteDataSource = siteDataSource
    }

    public func execute(_ site: Site) async throws {
        try await siteDataSource.update(site)
    }

}
