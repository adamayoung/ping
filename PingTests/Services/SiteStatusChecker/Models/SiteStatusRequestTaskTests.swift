//
//  SiteStatusRequestTaskTests.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import XCTest

final class SiteStatusRequestTaskTests: XCTestCase {

    func testURLRequestUsesCorrectURL() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "011FEE12-6955-4504-BBE6-0CAB6CCC642E"))
        let url = try XCTUnwrap(URL(string: "https://some.domain.com/api"))
        let task = SiteStatusRequestTask(
            siteID: siteID,
            url: url,
            method: "GET",
            timeout: 10000
        )

        let urlRequest = task.urlRequest

        XCTAssertEqual(urlRequest.url, url)
    }

    func testURLRequestIgnoresCache() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "0A8235D6-122C-4BF0-94E0-7321F36D6C70"))
        let url = try XCTUnwrap(URL(string: "https://someother.domain.com/api"))
        let task = SiteStatusRequestTask(
            siteID: siteID,
            url: url,
            method: "GET",
            timeout: 10000
        )

        let urlRequest = task.urlRequest

        XCTAssertEqual(urlRequest.cachePolicy, .reloadIgnoringLocalCacheData)
    }

    func testURLRequestUseCorrectMethod() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "AEF108F3-2FAA-4373-8ABC-69646BACA2F4"))
        let url = try XCTUnwrap(URL(string: "https://someother.domain.com/api"))
        let method = "GET"
        let timeout: TimeInterval = 9999
        let task = SiteStatusRequestTask(
            siteID: siteID,
            url: url,
            method: method,
            timeout: timeout
        )

        let urlRequest = task.urlRequest

        XCTAssertEqual(urlRequest.httpMethod, method)
    }

    func testURLRequestUseCorrectTimeout() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "EE2FF1C6-F4AB-4610-BABD-A0A033E99154"))
        let url = try XCTUnwrap(URL(string: "https://someother.domain.com/api"))
        let timeout: TimeInterval = 9999
        let task = SiteStatusRequestTask(
            siteID: siteID,
            url: url,
            method: "GET",
            timeout: timeout
        )

        let urlRequest = task.urlRequest

        XCTAssertEqual(urlRequest.timeoutInterval, timeout)
    }

}
