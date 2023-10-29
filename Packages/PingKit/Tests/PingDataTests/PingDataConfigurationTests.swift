//
//  PingDataConfigurationTests.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

@testable import PingData
import XCTest

final class PingDataConfigurationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        PingDataConfiguration.setInMemoryStorage(false)
    }

    override func tearDown() {
        PingDataConfiguration.setInMemoryStorage(false)
        super.tearDown()
    }

    func testSetInMemoryStorage() {
        XCTAssertFalse(PingDataConfiguration.inMemoryStorage)

        PingDataConfiguration.setInMemoryStorage(true)

        XCTAssertTrue(PingDataConfiguration.inMemoryStorage)
    }

}
