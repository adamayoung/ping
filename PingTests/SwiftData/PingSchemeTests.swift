//
//  PingSchemeTests.swift
//  PingTests
//
//  Created by Adam Young on 13/11/2023.
//

@testable import Ping
import SwiftData
import XCTest

final class PingSchemeTests: XCTestCase {

    var schema: Schema!

    override func setUp() {
        super.setUp()
        schema = Schema.ping
    }

    override func tearDown() {
        schema = nil
        super.tearDown()
    }

    func testSchemeContainsSiteGroupEntity() {
        let siteGroupEntityName = String(describing: SiteGroup.self)
        let entityNames = schema.entities.map(\.name)

        XCTAssertTrue(entityNames.contains(siteGroupEntityName))
    }

    func testSchemeContainsSiteEntity() {
        let siteEntityName = String(describing: Site.self)
        let entityNames = schema.entities.map(\.name)

        XCTAssertTrue(entityNames.contains(siteEntityName))
    }

    func testSchemeContainsSiteStatusRequestEntity() {
        let siteStatusRequestEntityName = String(describing: SiteStatusRequest.self)
        let entityNames = schema.entities.map(\.name)

        XCTAssertTrue(entityNames.contains(siteStatusRequestEntityName))
    }

    func testSchemeContainsSiteStatusEntity() {
        let siteStatusEntityName = String(describing: SiteStatus.self)
        let entityNames = schema.entities.map(\.name)

        XCTAssertTrue(entityNames.contains(siteStatusEntityName))
    }

}
