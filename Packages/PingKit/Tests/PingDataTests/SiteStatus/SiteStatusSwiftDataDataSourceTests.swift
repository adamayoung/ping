//
//  SiteStatusSwiftDataDataSourceTests.swift
//  PingDataTests
//
//  Created by Adam Young on 30/10/2023.
//

@testable import PingData
import PingDomain
import SwiftData
import XCTest

final class SiteStatusSwiftDataDataSourceTests: XCTestCase {

    var dataSource: SiteStatusSwiftDataDataSource!
    var modelContainer: ModelContainer!
    var modelActor: BackgroundModelActor!

    override func setUpWithError() throws {
        super.setUp()
        modelContainer = try ModelContainer.ping(inMemory: true)
        modelActor = BackgroundModelActor(container: modelContainer)
        dataSource = SiteStatusSwiftDataDataSource(modelActor: modelActor)
    }

    override func tearDown() {
        dataSource = nil
        modelActor = nil
        modelContainer = nil
        super.tearDown()
    }

    @MainActor
    func testFetchAllReturnsSiteStatusForSite() async throws {
        let googleSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")),
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )
        let googleSiteStatus1 = PingData.SiteStatus(
            id: try XCTUnwrap(UUID(uuidString: "13CF2F39-F932-4E65-ACD6-1B3505BA237D")),
            statusCode: .success,
            timestamp: Date(timeIntervalSince1970: 10000)
        )
        let googleSiteStatus2 = PingData.SiteStatus(
            id: try XCTUnwrap(UUID(uuidString: "8F476859-3205-4719-BDE0-F07D67CC0F84")),
            statusCode: .failure("Some error"),
            timestamp: Date(timeIntervalSince1970: 20000)
        )
        googleSite.statuses.append(contentsOf: [googleSiteStatus1, googleSiteStatus2])

        let gitHubSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")),
            name: "GitHub",
            url: try XCTUnwrap(URL(string: "https://github.com"))
        )
        let gitHubStatus1 = PingData.SiteStatus(
            id: try XCTUnwrap(UUID(uuidString: "2F88167E-30D1-4637-B3FB-B8070CFFEC74")),
            statusCode: .success,
            timestamp: Date(timeIntervalSince1970: 30000)
        )
        let gitHubStatus2 = PingData.SiteStatus(
            id: try XCTUnwrap(UUID(uuidString: "69C8C7B7-2DF2-45D3-BA10-D4C409D07315")),
            statusCode: .failure("Some error"),
            timestamp: Date(timeIntervalSince1970: 40000)
        )
        gitHubSite.statuses.append(contentsOf: [gitHubStatus1, gitHubStatus2])

        try await modelActor.insert(googleSite)
        try await modelActor.insert(gitHubSite)

        let siteStatuses = try await dataSource.fetchAll(for: googleSite.id)

        XCTAssertEqual(siteStatuses.count, 2)
        XCTAssertEqual(siteStatuses[0].siteID, googleSite.id)
        XCTAssertEqual(siteStatuses[1].siteID, googleSite.id)
    }

}
