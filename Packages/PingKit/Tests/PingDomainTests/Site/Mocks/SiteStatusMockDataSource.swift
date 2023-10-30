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

    private(set) var statusesCalled = false
    var statusesResult: Result<[SiteStatus], Error> = .success([])
    private(set) var lastStatusesSiteID: UUID?

    func statuses(for siteID: Site.ID) async throws -> [SiteStatus] {
        statusesCalled = true
        lastStatusesSiteID = siteID
        return try statusesResult.get()
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
