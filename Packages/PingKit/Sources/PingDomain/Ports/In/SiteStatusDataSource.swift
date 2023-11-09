//
//  SiteStatusDataSource.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol SiteStatusDataSource {

    func fetchAll(for siteIDs: [Site.ID]) async throws -> [Site.ID: [SiteStatus]]

    func fetchAll(for siteID: Site.ID) async throws -> [SiteStatus]

    func save(_ siteStatus: SiteStatus, for siteID: Site.ID) async throws

}
