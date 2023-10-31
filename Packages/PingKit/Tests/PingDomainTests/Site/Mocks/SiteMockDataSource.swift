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

    private(set) var fetchCalled = false
    var fetchResult: Result<Site?, Error> = .success(nil)
    private(set) var lastFetchID: Site.ID?

    func fetch(withID id: Site.ID) async throws -> PingDomain.Site? {
        fetchCalled = true
        lastFetchID = id
        return try fetchResult.get()
    }

    private(set) var fetchAllCalled = false
    var fetchAllResult: Result<[Site], Error> = .success([])

    func fetchAll() async throws -> [Site] {
        fetchAllCalled = true
        return try fetchAllResult.get()
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
