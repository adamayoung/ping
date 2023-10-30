//
//  AddSiteTests.swift
//  PingDomainTests
//
//  Created by Adam Young on 28/10/2023.
//

@testable import PingDomain
import XCTest

final class StoreSiteStatusTests: XCTestCase {

    var useCase: StoreSiteStatus!
    var siteStatusDataSource: SiteStatusMockDataSource!

    override func setUp() {
        super.setUp()
        siteStatusDataSource = SiteStatusMockDataSource()
        useCase = StoreSiteStatus(siteStatusDataSource: siteStatusDataSource)
    }

    override func tearDown() {
        useCase = nil
        siteStatusDataSource = nil
        super.tearDown()
    }

    func testExecute() async throws {
        let site = Site(
            id: try XCTUnwrap(UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")),
            name: "Twitter",
            url: try XCTUnwrap(URL(string: "https://twitter.com"))
        )
        let siteStatus = SiteStatus(
            id: try XCTUnwrap(UUID(uuidString: "0D85E45E-F8B2-42A7-92E6-A986C2905A49")),
            siteID: site.id,
            statusCode: .success,
            timestamp: Date(timeIntervalSince1970: 1000)
        )

        try await useCase.execute(siteStatus: siteStatus, for: site)

        XCTAssertTrue(siteStatusDataSource.saveCalled)
        XCTAssertEqual(siteStatusDataSource.lastSaveSiteStatus, siteStatus)
        XCTAssertEqual(siteStatusDataSource.lastSaveSiteSiteID, site.id)
    }

}
