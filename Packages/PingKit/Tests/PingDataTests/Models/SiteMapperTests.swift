//
//  SiteMapperTests.swift
//  PingDataTests
//
//  Created by Adam Young on 29/10/2023.
//

@testable import PingData
import PingDomain
import SwiftData
import XCTest

final class SiteMapperTests: XCTestCase {

    var modelContainer: ModelContainer!

    override func setUpWithError() throws {
        super.setUp()
        modelContainer = try ModelContainer.ping(inMemory: true)
    }

    override func tearDown() {
        modelContainer = nil
        super.tearDown()
    }

    func testMapFromDomainSiteToDataSite() throws {
        let domainSite = PingDomain.Site(
            id: try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")),
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )
        let expectedDataSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")),
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )

        let dataSite = PingData.Site(site: domainSite)

        XCTAssertEqual(dataSite.id, expectedDataSite.id)
        XCTAssertEqual(dataSite.name, expectedDataSite.name)
        XCTAssertEqual(dataSite.url, expectedDataSite.url)
    }

    func testMapFromDataSiteToDomainSite() throws {
        let dataSite = PingData.Site(
            id: try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")),
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )

        let expectedDomainSite = PingDomain.Site(
            id: try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")),
            name: "Google",
            url: try XCTUnwrap(URL(string: "https://www.google.com"))
        )

        let domainSite = PingDomain.Site(site: dataSite)

        XCTAssertEqual(domainSite.id, expectedDomainSite.id)
        XCTAssertEqual(domainSite.name, expectedDomainSite.name)
        XCTAssertEqual(domainSite.url, expectedDomainSite.url)
    }

}
