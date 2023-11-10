//
//  ManageSiteGroupsTests.swift
//  PingUITests
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation

import XCTest

final class ManageSiteGroupsTests: UITestCaseBase {

    func testAddingNewSiteGroup() {
        let siteGroupName = "Test Site Group"

        initialScreen
            .tapSitesActionMenuButton()
            .tapManageSiteGroupsButton()
            .tapAddButton()
            .typeName(siteGroupName)
            .tapAddButton()
            .assertSite(withName: siteGroupName, isPresent: true)
    }

    func testDeleteGroup() {
        let siteGroupID = UUID.developmentSiteGroupIDPreview

        initialScreen
            .tapSitesActionMenuButton()
            .tapManageSiteGroupsButton()
            .swipLeftAndDeleteSiteGroup(withID: siteGroupID)
            .assertSiteGroup(withID: siteGroupID, isPresent: false)
    }

}
