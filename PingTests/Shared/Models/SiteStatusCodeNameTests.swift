//
//  SiteStatusCodeNameTests.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import SwiftUI
import XCTest

final class SiteStatusCodeNameTests: XCTestCase {

    func testLocalizedNameForSuccessCode() {
        let code = SiteStatus.Code.success

        XCTAssertEqual(code.localizedName, "SITE_STATUS_SUCCESS")
    }

    func testLocalizedNameForFailureCode() {
        let code = SiteStatus.Code.failure("")

        XCTAssertEqual(code.localizedName, "SITE_STATUS_FAILURE")
    }

    func testLocalizedNameForUnknownCode() {
        let code = SiteStatus.Code.unknown

        XCTAssertEqual(code.localizedName, "SITE_STATUS_UNKNOWN")
    }

}
