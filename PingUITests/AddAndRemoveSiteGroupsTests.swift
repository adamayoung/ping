//
//  AddAndRemoveSiteGroupsTests.swift
//  PingUITests
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation

import XCTest

final class AddAndRemoveSiteGroupsTests: UITestCaseBase {

    func testAddingNewSiteGroup() {
        let siteGroupName = "Test Site Group"

        initialScreen
            .tapSitesActionMenuButton()
            .tapAddSiteGroupButton()
            .typeName(siteGroupName)
            .tapAddButton()
            .tapSitesActionMenuButton()
            .tapManageSiteGroupsButton()
            .assertSiteGroup(withName: siteGroupName, isPresent: true)
    }

    func testDeleteGroup() {
        let siteGroupID = UUID.developmentSiteGroup

        initialScreen
            .tapSitesActionMenuButton()
            .tapManageSiteGroupsButton()
            .swipLeftAndDeleteSiteGroup(withID: siteGroupID)
            .assertSiteGroup(withID: siteGroupID, isPresent: false)
    }

}
