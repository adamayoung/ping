//
//  AddSiteTests.swift
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
            .tapAddSiteButton()
            .assertAddButtonIsDisabled()
            .typeName(siteName)
            .typeURL("https://www.domain.com")
            .assertAddButtonIsEnabled()
            .tapAddButton()
            .assertSitePresent(withName: siteName)
    }

    func testCannotAddSiteWithInvalidURL() {
        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .tapAddSiteButton()
            .assertAddButtonIsDisabled()
            .typeName("Test Site")
            .typeURL("aaa")
            .assertAddButtonIsDisabled()
    }

    func testCancellingAddNewSite() {
        let siteName = "Test Site"

        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .tapAddSiteButton()
            .typeName(siteName)
            .typeURL("https://www.domain.com")
            .tapCancelButton()
            .verifySitesVisible()
            .assertSiteNotPresent(withName: siteName)
    }

    func testDeleteSiteFromSitesList() {
        let siteID = UUID.googleSiteIDPreview

        initialScreen
            .verifySitesVisible()
            .swipLeftAndDeleteSite(withID: siteID)
            .assertSiteNotPresent(withID: siteID)
    }

}
