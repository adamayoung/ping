//
//  SiteStatusDataSource.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol SiteStatusDataSource {

    func statuses(for siteID: Site.ID) async throws -> [SiteStatus]

    func save(siteStatus: SiteStatus, for siteID: Site.ID) async throws

}
