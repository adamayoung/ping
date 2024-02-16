//
//  SiteStatusCodeIconTests.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import SwiftUI
import XCTest

final class SiteStatusCodeIconTests: XCTestCase {

    func testIconNameForSuccessCode() {
        let code = SiteStatus.Code.success

        XCTAssertEqual(code.iconName, "wifi.circle.fill")
    }

    func testIconNameForFailureCode() {
        let code = SiteStatus.Code.failure("")

        XCTAssertEqual(code.iconName, "exclamationmark.triangle.fill")
    }

    func testIconNameForUnknownCode() {
        let code = SiteStatus.Code.unknown

        XCTAssertEqual(code.iconName, "questionmark.circle.fill")
    }

    func testIconColorForSuccessCode() {
        let code = SiteStatus.Code.success

        XCTAssertEqual(code.iconColor, .green)
    }

    func testIconColorForFailureCode() {
        let code = SiteStatus.Code.failure("")

        XCTAssertEqual(code.iconColor, .yellow)
    }

    func testIconColorForUnknownCode() {
        let code = SiteStatus.Code.unknown

        XCTAssertEqual(code.iconColor, .gray)
    }

}
