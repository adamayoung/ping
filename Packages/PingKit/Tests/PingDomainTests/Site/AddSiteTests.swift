//
//  AddSiteTests.swift
//  PingDomainTests
//
//  Created by Adam Young on 28/10/2023.
//

@testable import PingDomain
import XCTest

final class AddSiteTests: XCTestCase {

    var useCase: AddSite!
    var siteDataSource: SiteMockDataSource!

    override func setUp() {
        super.setUp()
        siteDataSource = SiteMockDataSource()
        useCase = AddSite(siteDataSource: siteDataSource)
    }

    override func tearDown() {
        useCase = nil
        siteDataSource = nil
        super.tearDown()
    }

    @MainActor
    func testExecute() async throws {
        let site = Site(
            id: try XCTUnwrap(UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")),
            name: "Twitter",
            url: try XCTUnwrap(URL(string: "https://twitter.com"))
        )
        siteDataSource.saveResult = .success(())

        try await useCase.execute(site: site)

        XCTAssertTrue(siteDataSource.saveCalled)
        XCTAssertEqual(siteDataSource.lastSavedSite, site)
    }

}
