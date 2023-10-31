//
//  SiteStatusMockDataSource.swift
//  PingDomainTests
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

final class SiteStatusMockDataSource: SiteStatusDataSource {

    init() { }

    private(set) var fetchAllCalled = false
    var fetchAllResult: Result<[SiteStatus], Error> = .success([])
    private(set) var lastfetchAllSiteID: UUID?

    func fetchAll(for siteID: Site.ID) async throws -> [SiteStatus] {
        fetchAllCalled = true
        lastfetchAllSiteID = siteID
        return try fetchAllResult.get()
    }

    func fetchAllLatest() async throws -> [Site.ID: SiteStatus] {
        return [:]
    }

    func fetch(latestFor siteID: Site.ID) async throws -> SiteStatus? {
        return nil
    }

    private(set) var saveCalled = false
    var saveResult: Result<Void, Error> = .success(())
    private(set) var lastSaveSiteStatus: SiteStatus?
    private(set) var lastSaveSiteSiteID: Site.ID?

    func save(siteStatus: SiteStatus, for siteID: Site.ID) async throws {
        saveCalled = true
        lastSaveSiteStatus = siteStatus
        lastSaveSiteSiteID = siteID
        try saveResult.get()
    }

}
