//
//  ManageSiteGroupsTests.swift
//  PingUITests
//
//  Created by Adam Young on 10/11/2023.
//

import XCTest

final class ManageSiteGroupsTests: UITestCaseBase {

    func testAddingNewSiteGroup() {
        let siteGroupName = "Test Site Group"

        initialScreen
            .tapSitesActionMenuButton()
            .selectAddSiteGroupMenuItem()
            .typeName(siteGroupName)
            .tapAddButton()
            .tapSitesActionMenuButton()
            .selectManageSiteGroupsMenuItem()
            .assertSiteGroup(withName: siteGroupName, isPresent: true)
    }

    #if os(iOS)
    func testDeleteGroup() {
        let siteGroupID = UUID.developmentSiteGroup

        initialScreen
            .tapSitesActionMenuButton()
            .selectManageSiteGroupsMenuItem()
            .swipLeftAndDeleteSiteGroup(withID: siteGroupID)
            .assertSiteGroup(withID: siteGroupID, isPresent: false)
    }
    #endif

}
