//
//  MenuItemTests.swift
//  PingTests
//
//  Created by Adam Young on 26/10/2023.
//

@testable import Ping
import XCTest

final class MenuItemTests: XCTestCase {

    func testDefault() {
        let expectedMenuItem: MenuItem? = {
            #if os(macOS)
            return .summary
            #else
            return nil
            #endif
        }()

        let menuItem = MenuItem.default

        XCTAssertEqual(menuItem, expectedMenuItem)
    }

}
