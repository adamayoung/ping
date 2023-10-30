//
//  CheckSiteTests.swift
//  PingDomainTests
//
//  Created by Adam Young on 29/10/2023.
//

@testable import PingDomain
import XCTest

final class CheckSiteTests: XCTestCase {

    var useCase: CheckSite!
    var siteCheckService: SiteCheckMockService!
    var siteDataSource: SiteMockDataSource!

    override func setUp() {
        super.setUp()
        siteCheckService = SiteCheckMockService()
        siteDataSource = SiteMockDataSource()
        useCase = CheckSite(siteCheckService: siteCheckService, siteDataSource: siteDataSource)
    }

    override func tearDown() {
        useCase = nil
        siteDataSource = nil
        siteCheckService = nil
        super.tearDown()
    }

    func testExecuteWhenSiteDoesNotExistReturnsUnknownStatus() async throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "52600E41-DEFE-4294-B160-32EF2E65FDC7"))
        siteDataSource.siteWithIDResult = .success(nil)

        let status = try await useCase.execute(siteID: siteID)

        XCTAssertEqual(siteDataSource.lastSiteWithIDSiteID, siteID)
        XCTAssertEqual(status, .unknown)
    }

    func testExecuteWhenSiteExistsAndCheckIsSuccessfulReturnsSuccessStatus() async throws {
        let site = Site(
            id: try XCTUnwrap(UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")),
            name: "Twitter",
            url: try XCTUnwrap(URL(string: "https://twitter.com"))
        )
        siteDataSource.siteWithIDResult = .success(site)
        siteCheckService.checkSiteResult = .success(.success)

        let status = try await useCase.execute(siteID: site.id)

        XCTAssertEqual(siteDataSource.lastSiteWithIDSiteID, site.id)
        XCTAssertEqual(siteCheckService.lastCheckSite, site)
        XCTAssertEqual(status, .success)
    }

    func testExecuteWhenSiteExistsAndCheckFailsReturnsFailureStatus() async throws {
        let site = Site(
            id: try XCTUnwrap(UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")),
            name: "Twitter",
            url: try XCTUnwrap(URL(string: "https://twitter.com"))
        )
        siteDataSource.siteWithIDResult = .success(site)
        siteCheckService.checkSiteResult = .success(.failure)

        let status = try await useCase.execute(siteID: site.id)

        XCTAssertEqual(siteDataSource.lastSiteWithIDSiteID, site.id)
        XCTAssertEqual(siteCheckService.lastCheckSite, site)
        XCTAssertEqual(status, .failure)
    }

}
