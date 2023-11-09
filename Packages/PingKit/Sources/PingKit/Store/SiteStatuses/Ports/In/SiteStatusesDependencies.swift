//
//  SiteStatusesDependencies.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public protocol SiteStatusesDependencies {

    func siteStatuses(for siteIDs: [Site.ID]) async throws -> [Site.ID: [SiteStatus]]

    func siteStatuses(for siteID: Site.ID) async throws -> [SiteStatus]

    func checkSiteStatuses(for site: [Site]) async throws -> [Site.ID: SiteStatus]

    func checkSiteStatus(for site: Site) async throws -> SiteStatus

    func add(_ siteStatus: SiteStatus, for siteID: Site.ID) async throws

}
