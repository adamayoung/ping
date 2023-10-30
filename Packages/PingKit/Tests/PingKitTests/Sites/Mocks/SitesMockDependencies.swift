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

    var checkResult: Result<PingKit.SiteStatusCode, Error> = .failure(SitesMockDependenciesError())
    private(set) var lastCheckSite: Site?

    func check(site: PingKit.Site) async throws -> PingKit.SiteStatusCode {
        lastCheckSite = site
        return try checkResult.get()
    }

}

extension SitesMockDependencies {

    struct SitesMockDependenciesError: Error { }

}
