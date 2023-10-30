//
//  CheckSiteTests.swift
//  PingDomainTests
//
//  Created by Adam Young on 29/10/2023.
//

@testable import PingDomain
import XCTest

final class CheckSiteStatusTests: XCTestCase {

    var useCase: CheckSiteStatus!
    var siteStatusService: SiteStatusMockService!

    override func setUp() {
        super.setUp()
        siteStatusService = SiteStatusMockService()
        useCase = CheckSiteStatus(siteStatusService: siteStatusService)
    }

    override func tearDown() {
        useCase = nil
        siteStatusService = nil
        super.tearDown()
    }

    func testExecuteReturnsStatus() async throws {
        let site = Site(
            id: try XCTUnwrap(UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")),
            name: "Twitter",
            url: try XCTUnwrap(URL(string: "https://twitter.com"))
        )
        let expectedSiteStatus = SiteStatus(
            id: try XCTUnwrap(UUID(uuidString: "7E2DC5F9-BB23-4D65-8A31-FD6CB4E175B0")),
            siteID: site.id,
            statusCode: .success,
            timestamp: Date(timeIntervalSince1970: 2000)
        )
        siteStatusService.checkSiteResult = .success(expectedSiteStatus)

        let siteStatus = try await useCase.execute(site: site)

        XCTAssertEqual(siteStatusService.lastCheckSite, site)
        XCTAssertEqual(siteStatus, expectedSiteStatus)
    }

}
