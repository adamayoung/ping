//
//  SiteStatusDataSource.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol SiteStatusDataSource {

    func statuses(for siteID: UUID) async throws -> [SiteStatus]

    func save(status: SiteStatus, for siteID: UUID) async throws

}
