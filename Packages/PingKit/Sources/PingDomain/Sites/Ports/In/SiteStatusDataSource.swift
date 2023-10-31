//
//  SiteStatusDataSource.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol SiteStatusDataSource {

    func fetchAll(for siteID: Site.ID) async throws -> [SiteStatus]

    func fetchAllLatest() async throws -> [Site.ID: SiteStatus]

    func fetch(latestFor siteID: Site.ID) async throws -> SiteStatus?

    func save(siteStatus: SiteStatus, for siteID: Site.ID) async throws

}
