//
//  ManageSitesTests.swift
//  PingUITests
//
//  Created by Adam Young on 26/10/2023.
//

import XCTest

final class ManageSitesTests: UITestCaseBase {

    func testAddSite() {
        let siteName = "Test Site"

        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .selectAddSiteMenuItem()
            .assertAddButton(isEnabled: false)
            .typeName(siteName)
            .typeURL("www.domain.com")
            .assertAddButton(isEnabled: true)
            .tapAddButton()
            .assertSite(withName: siteName, isPresent: true)
    }

    func testAddSiteWithInGroup() {
        let siteName = "Test Site"
        let siteGroupID = UUID.developmentSiteGroup

        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .selectAddSiteMenuItem()
            .assertAddButton(isEnabled: false)
            .typeName(siteName)
            .typeURL("www.domain.com")
            .tapSiteGroupPicker()
            .tapSiteGroupItem(withID: siteGroupID)
            .assertAddButton(isEnabled: true)
            .tapAddButton()
            .assertSite(withName: siteName, isPresent: true)
    }

    func testCannotAddSiteWithInvalidURL() {
        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .selectAddSiteMenuItem()
            .assertAddButton(isEnabled: false)
            .typeName("Test Site")
            .typeURL("aaa")
            .assertAddButton(isEnabled: false)
    }

    func testCancellingAddNewSite() {
        let siteName = "Test Site"

        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .selectAddSiteMenuItem()
            .typeName(siteName)
            .typeURL("www.domain.com")
            .tapCancelButton()
            .verifySitesVisible()
            .assertSite(withName: siteName, isPresent: false)
    }

    #if os(iOS)
    func testDeleteSiteFromSitesList() {
        let siteID = UUID.googleSite

        initialScreen
            .verifySitesVisible()
            .swipeLeftAndDeleteSite(withID: siteID)
            .assertSite(withID: siteID, isPresent: false)
    }
    #endif

    #if os(macOS)
    func testDeleteSiteFromSitesList() {
        let siteID = UUID.googleSite

        initialScreen
            .verifySitesVisible()
            .contextMenuForSite(id: siteID)
            .selectDeleteSiteMenuItem()
            .assertSite(withID: siteID, isPresent: false)
    }
    #endif

}
