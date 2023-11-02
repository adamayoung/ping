//
//  SitesStateTests.swift
//  PingKitTests
//
//  Created by Adam Young on 27/10/2023.
//

@testable import PingKit
import XCTest

final class SitesStateTests: XCTestCase {

    func testDefaultState() {
        let expectedState = SitesState(
            all: []
        )

        let state = SitesState()

        XCTAssertEqual(state, expectedState)
    }

}
