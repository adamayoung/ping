//
//  RemoveSite.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public final class RemoveSite: RemoveSiteUseCase {

    private let siteDataSource: any SiteDataSource

    public init(siteDataSource: some SiteDataSource) {
        self.siteDataSource = siteDataSource
    }

    public func execute(_ siteID: Site.ID) async throws {
        try await siteDataSource.delete(siteID)
    }

}
