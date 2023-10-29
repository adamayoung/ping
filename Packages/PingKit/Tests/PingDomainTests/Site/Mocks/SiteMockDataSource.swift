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

}
