//
//  SiteSwiftDataDataSourceTests.swift
//  PingDataTests
//
//  Created by Adam Young on 29/10/2023.
//

@testable import PingData
import SwiftData
import XCTest

final class SiteSwiftDataDataSourceTests: XCTestCase {

    var dataSource: SiteSwiftDataDataSource!
    var modelContainer: ModelContainer!
    var model: BackgroundModelActor<Site>!

    override func setUpWithError() throws {
        super.setUp()
        modelContainer = try ModelContainer.ping(inMemory: true)
        model = BackgroundModelActor<Site>(container: modelContainer)
        dataSource = SiteSwiftDataDataSource(model: model)
    }

    override func tearDown() {
        dataSource = nil
        model = nil
        modelContainer = nil
        super.tearDown()
    }

    func testSites() async throws {
        let googleSite = Site(
            id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
            name: "Google",
            url: URL(string: "https://www.google.com")!
        )
        let gitHubSite = Site(
            id: UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!,
            name: "GitHub",
            url: URL(string: "https://github.com")!
        )
        let twitterSite = Site(
            id: UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!,
            name: "Twitter",
            url: URL(string: "https://twitter.com")!
        )

        try await model.save([twitterSite, googleSite, gitHubSite])

        let sites = try await dataSource.sites()

        XCTAssertFalse(sites.isEmpty)
    }

}
