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

}
