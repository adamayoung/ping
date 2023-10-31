//
//  FetchSites.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public final class FetchSites: FetchSitesUseCase {

    private let siteDataSource: any SiteDataSource

    public init(siteDataSource: some SiteDataSource) {
        self.siteDataSource = siteDataSource
    }

    public func execute() async throws -> [Site] {
        let sites = try await siteDataSource.fetchAll()
        return sites
    }

}
