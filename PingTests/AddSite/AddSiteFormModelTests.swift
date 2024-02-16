//
//  AddSiteFormModelTests.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import XCTest

final class AddSiteFormModelTests: XCTestCase {

    var viewModel: AddSiteFormModel!

    override func setUp() {
        super.setUp()
        viewModel = AddSiteFormModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testTimeoutDefaultValue() {
        XCTAssertEqual(viewModel.timeout, 10000)
    }

    func testMethodDefaultValue() {
        XCTAssertEqual(viewModel.method, .get)
    }

    func testIsValidWhenNameIsEmptyURLIsEmptyTimeoutIsZeroReturnsFalse() {
        viewModel.name = ""
        viewModel.url = ""
        viewModel.timeout = 0

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenNameIsEmptyReturnsFalse() {
        viewModel.name = ""
        viewModel.url = "https://some.domain.com/api"
        viewModel.timeout = 10000

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenURLIsNotAValidURLReturnsFalse() {
        viewModel.name = "Some Site"
        viewModel.url = ""
        viewModel.timeout = 10000

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenURLDoesNotContainASchemeReturnsFalse() {
        viewModel.name = "Some Site"
        viewModel.url = "some.domain.com"
        viewModel.timeout = 10000

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenURLSchemeIsNotHTTPSReturnsFalse() {
        viewModel.name = "Some Site"
        viewModel.url = "http://some.domain.com/api"
        viewModel.timeout = 10000

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenURLDoesNotContainAHostReturnsFalse() {
        viewModel.name = "Some Site"
        viewModel.url = "https:/api"
        viewModel.timeout = 10000

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenURLHostDoesNotContainAPeriodReturnsFalse() {
        viewModel.name = "Some Site"
        viewModel.url = "https://domain"
        viewModel.timeout = 10000

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenURLHostEndsWithAPeriodReturnsFalse() {
        viewModel.name = "Some Site"
        viewModel.url = "https://domain.com."
        viewModel.timeout = 10000

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenTimeoutIs999ReturnsFalse() {
        viewModel.name = "Some Site"
        viewModel.url = "https://some.domain.com"
        viewModel.timeout = 999

        XCTAssertFalse(viewModel.isValid)
    }

    func testIsValidWhenNameIsNotEmptyURLIsAValidURLTimeoutIsTenThousandReturnsTrue() {
        viewModel.name = "Some Site"
        viewModel.url = "https://some.domain.com/api"
        viewModel.timeout = 1000

        XCTAssertTrue(viewModel.isValid)
    }

}
