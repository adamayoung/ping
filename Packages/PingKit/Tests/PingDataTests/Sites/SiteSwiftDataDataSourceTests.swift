//
//  SiteSwiftDataDataSourceTests.swift
//  PingDataTests
//
//  Created by Adam Young on 29/10/2023.
//

@testable import PingData
import PingDomain
import SwiftData
import XCTest

final class SiteSwiftDataDataSourceTests: XCTestCase {

    var dataSource: SiteSwiftDataDataSource!
    var modelContainer: ModelContainer!
    var model: BackgroundModelActor<PingData.Site>!

    override func setUpWithError() throws {
        super.setUp()
        modelContainer = try ModelContainer.ping(inMemory: true)
        model = BackgroundModelActor<PingData.Site>(container: modelContainer)
        dataSource = SiteSwiftDataDataSource(model: model)
    }

    override func tearDown() {
        dataSource = nil
        model = nil
        modelContainer = nil
        super.tearDown()
    }

    func testSites() async throws {
        let googleSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")),
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )
        let gitHubSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")),
            name: "GitHub",
            url: try XCTUnwrap(URL(string: "https://github.com"))
        )
        let twitterSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")),
            name: "Twitter",
            url: try XCTUnwrap(URL(string: "https://twitter.com"))
        )

        try await model.save([twitterSite, googleSite, gitHubSite])

        let sites = try await dataSource.sites()

        XCTAssertFalse(sites.isEmpty)
    }

    func testSaveSavesSite() async throws {
        let expectedSiteID = try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855"))
        let siteToSave = PingDomain.Site(
            id: expectedSiteID,
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )

        try await dataSource.save(siteToSave)

        let siteModels = try await model.fetch()

        XCTAssertEqual(siteModels.count, 1)
        let site = try XCTUnwrap(siteModels.first)

        XCTAssertEqual(site.id, expectedSiteID)
    }

    func testDeleteDeletesSite() async throws {
        let googleSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")),
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )
        let gitHubSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")),
            name: "GitHub",
            url: try XCTUnwrap(URL(string: "https://github.com"))
        )
        try await model.save([googleSite, gitHubSite])

        try await dataSource.delete(googleSite.id)

        let siteModels = try await model.fetch()

        XCTAssertEqual(siteModels.count, 1)
        let site = try XCTUnwrap(siteModels.first)

        XCTAssertEqual(site.id, gitHubSite.id)
    }

}
