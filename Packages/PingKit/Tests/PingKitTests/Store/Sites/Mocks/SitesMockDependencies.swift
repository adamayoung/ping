//
//  SitesMockDependencies.swift
//  PinkKitTests
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingKit

final class SitesMockDependencies: SitesDependencies {

    var sitesResult: Result<[Site], Error> = .success([])

    func sites() async throws -> [Site] {
        try sitesResult.get()
    }

    private(set) var lastAddedSite: Site?

    func add(site: Site) async throws {
        lastAddedSite = site
    }

    private(set) var lastRemovedSiteID: Site.ID?

    func remove(id: Site.ID) async throws {
        lastRemovedSiteID = id
    }

    var siteStatusResult: Result<SiteStatus, Error> = .failure(SitesMockDependenciesError())
    private(set) var lastSiteStatusSite: Site?

    func siteStatus(site: Site) async throws -> SiteStatus {
        lastSiteStatusSite = site
        return try siteStatusResult.get()
    }

    var allSiteStatusesResult: Result<[Site.ID: SiteStatus], Error> = .failure(SitesMockDependenciesError())

    func allSiteStatuses() async throws -> [Site.ID: SiteStatus] {
        try allSiteStatusesResult.get()
    }

    var storeResult: Result<Void, Error> = .success(())
    private(set) var lastStoreSiteStatues: SiteStatus?
    private(set) var lastStoreSite: Site?

    func store(siteStatus: SiteStatus, for site: PingKit.Site) async throws {
        lastStoreSiteStatues = siteStatus
        lastStoreSite = site
        try storeResult.get()
    }

    func latestSiteStatuses() async throws -> [Site.ID: SiteStatus] {
        return [:]
    }

}

extension SitesMockDependencies {

    struct SitesMockDependenciesError: Error { }

}
