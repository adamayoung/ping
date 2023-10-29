//
//  FetchSitesTests.swift
//  PingDomainTests
//
//  Created by Adam Young on 28/10/2023.
//

@testable import PingDomain
import XCTest

final class FetchSitesTests: XCTestCase {

    var useCase: FetchSites!
    var siteDataSource: SiteMockDataSource!

    override func setUp() {
        super.setUp()
        siteDataSource = SiteMockDataSource()
        useCase = FetchSites(siteDataSource: siteDataSource)
    }

    override func tearDown() {
        useCase = nil
        siteDataSource = nil
        super.tearDown()
    }

    func testExecute() async throws {
        let expectedSites = [Site]()
        siteDataSource.sitesResult = .success(expectedSites)

        let sites = try await useCase.execute()

        XCTAssertEqual(sites, expectedSites)
    }

}
