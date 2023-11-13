//
//  SiteStatusRequestTaskMapperTests.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import SwiftData
import XCTest

final class SiteStatusRequestTaskMapperTests: XCTestCase {

    var modelContainer: ModelContainer!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let modelConfiguration = ModelConfiguration(schema: Schema.ping, isStoredInMemoryOnly: true,
                                                    cloudKitDatabase: .none)
        modelContainer = try ModelContainer(for: Schema.ping, configurations: modelConfiguration)
    }

    override func tearDown() {
        modelContainer = nil
        super.tearDown()
    }

    func testWhenSiteRequestIsNilReturnsNil() {
        let task = SiteStatusRequestTask(siteRequest: nil)

        XCTAssertNil(task)
    }

    func testWhenSiteRequestSiteIsNilReturnsNil() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain.com/api"))
        let siteRequest = SiteStatusRequest(url: url)

        let task = SiteStatusRequestTask(siteRequest: siteRequest)

        XCTAssertNil(task)
    }

    @MainActor
    func testWhenSiteRequestHasSiteReturnsTaskWithSiteID() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "F2BE41FC-3320-4ED7-A8AB-ECC8F955AEB8"))
        let url = try XCTUnwrap(URL(string: "https://some.domain.com/api"))
        let siteRequest = SiteStatusRequest(url: url)
        let site = Site(id: siteID, name: "Some Site", request: siteRequest)
        modelContainer.mainContext.insert(site)

        let task = try XCTUnwrap(SiteStatusRequestTask(siteRequest: siteRequest))

        XCTAssertEqual(task.siteID, siteID)
    }

    @MainActor
    func testWhenSiteRequestHasSiteReturnsTaskWithMethod() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "F2BE41FC-3320-4ED7-A8AB-ECC8F955AEB8"))
        let url = try XCTUnwrap(URL(string: "https://some.domain.com/api"))
        let siteRequest = SiteStatusRequest(url: url)
        let site = Site(id: siteID, name: "Some Site", request: siteRequest)
        modelContainer.mainContext.insert(site)

        let task = try XCTUnwrap(SiteStatusRequestTask(siteRequest: siteRequest))

        XCTAssertEqual(task.method, "GET")
    }

    @MainActor
    func testWhenSiteRequestHasSiteReturnsTaskWithTimeout() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "F2BE41FC-3320-4ED7-A8AB-ECC8F955AEB8"))
        let url = try XCTUnwrap(URL(string: "https://some.domain.com/api"))
        let timeout: TimeInterval = 9999
        let siteRequest = SiteStatusRequest(url: url, timeout: timeout)
        let site = Site(id: siteID, name: "Some Site", request: siteRequest)
        modelContainer.mainContext.insert(site)

        let task = try XCTUnwrap(SiteStatusRequestTask(siteRequest: siteRequest))

        XCTAssertEqual(task.timeout, timeout)
    }

}
