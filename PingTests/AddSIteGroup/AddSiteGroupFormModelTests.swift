//
//  AddSiteGroupFormModelTests.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import XCTest

final class AddSiteGroupFormModelTests: XCTestCase {

    var formModel: AddSiteGroupFormModel!

    override func setUp() {
        super.setUp()
        formModel = AddSiteGroupFormModel()
    }

    override func tearDown() {
        formModel = nil
        super.tearDown()
    }

    func testIsValidWhenNameIsEmptyReturnsFalse() {
        formModel.name = ""

        XCTAssertFalse(formModel.isValid)
    }

    func testIsValidWhenNameHasValueReturnsTrue() {
        formModel.name = "Some Site Group"

        XCTAssertTrue(formModel.isValid)
    }

    func testSiteGroupWhenFormIsNotValidReturnsNil() {
        formModel.name = ""

        XCTAssertNil(formModel.siteGroup)
    }

    func testSiteGroupWhenFormIsValidReturnsSite() {
        formModel.name = "Some Site Group"

        XCTAssertNotNil(formModel.siteGroup)
    }

    func testSiteGroupWhenFormIsValidReturnsSiteWithCorrectName() {
        let name = "Some Site Group"
        formModel.name = name

        let site = formModel.siteGroup

        XCTAssertEqual(site?.name, name)
    }

}
