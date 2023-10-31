//
//  RemoveSiteTests.swift
//  PingDomainTests
//
//  Created by Adam Young on 28/10/2023.
//

@testable import PingDomain
import XCTest

final class RemoveSiteTests: XCTestCase {

    var useCase: RemoveSite!
    var siteDataSource: SiteMockDataSource!

    override func setUp() {
        super.setUp()
        siteDataSource = SiteMockDataSource()
        useCase = RemoveSite(siteDataSource: siteDataSource)
    }

    override func tearDown() {
        useCase = nil
        siteDataSource = nil
        super.tearDown()
    }

    @MainActor
    func testExecute() async throws {
        let id = try XCTUnwrap(UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A"))
        siteDataSource.deleteResult = .success(())

        try await useCase.execute(id: id)

        XCTAssertTrue(siteDataSource.deleteCalled)
        XCTAssertEqual(siteDataSource.lastDeletedSiteID, id)
    }

}
