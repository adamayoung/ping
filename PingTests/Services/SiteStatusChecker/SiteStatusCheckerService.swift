//
//  SiteStatusCheckerService.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import XCTest

final class SiteStatusCheckerServiceTests: XCTestCase {

    var service: SiteStatusCheckerService!

    override func setUp() {
        super.setUp()
        service = SiteStatusCheckerService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

}
