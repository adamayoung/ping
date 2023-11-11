//
//  AddSiteTests.swift
//  PingUITests
//
//  Created by Adam Young on 26/10/2023.
//

import XCTest

final class AddAndRemoveSitesTests: UITestCaseBase {

    func testAddSite() {
        let siteName = "Test Site"

        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .tapAddSiteButton()
            .assertAddButton(isEnabled: false)
            .typeName(siteName)
            .typeURL("www.domain.com")
            .assertAddButton(isEnabled: true)
            .tapAddButton()
            .assertSite(withName: siteName, isPresent: true)
    }

    func testCannotAddSiteWithInvalidURL() {
        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .tapAddSiteButton()
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
            .tapAddSiteButton()
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
            .deleteSite(withID: siteID)
            .assertSite(withID: siteID, isPresent: false)
    }
    #endif

}
