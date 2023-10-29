//
//  SiteMockDataSource.swift
//  PingDomainTests
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

final class SiteMockDataSource: SiteDataSource {

    init() { }

    private(set) var sitesCalled = false
    var sitesResult: Result<[Site], Error> = .success([])

    func sites() async throws -> [Site] {
        sitesCalled = true
        return try sitesResult.get()
    }

    private(set) var saveCalled = false
    var saveResult: Result<Void, Error> = .success(())
    private(set) var lastSavedSite: Site?

    func save(_ site: Site) async throws {
        saveCalled = true
        lastSavedSite = site
        try saveResult.get()
    }

    private(set) var deleteCalled = false
    var deleteResult: Result<Void, Error> = .success(())
    private(set) var lastDeletedSiteID: Site.ID?
    func delete(_ id: UUID) async throws {
        deleteCalled = true
        lastDeletedSiteID = id
        try deleteResult.get()
    }

}
