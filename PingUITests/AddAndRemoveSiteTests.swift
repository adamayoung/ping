//
//  AddSiteTests.swift
//  PingUITests
//
//  Created by Adam Young on 26/10/2023.
//

import XCTest

final class AddAndRemoveSiteTests: UITestCase {

    func testAddSite() {
        let siteName = "Test Site"

        SitesScreen(app: app)
            .verifySitesVisible()
            .tapAddSiteButton()
            .verifyAddButtonIsDisabled()
            .typeName(siteName)
            .typeURL("https://www.domain.com")
            .verifyAddButtonIsEnabled()
            .tapAddButton()
            .verifySitePresent(withName: siteName)
    }

    func testCannotAddSiteWithInvalidURL() {
        SitesScreen(app: app)
            .verifySitesVisible()
            .tapAddSiteButton()
            .verifyAddButtonIsDisabled()
            .typeName("Test Site")
            .typeURL("aaa")
            .verifyAddButtonIsDisabled()
    }

    func testCancellingAddNewSite() {
        let siteName = "Test Site"

        SitesScreen(app: app)
            .verifySitesVisible()
            .tapAddSiteButton()
            .typeName(siteName)
            .typeURL("https://www.domain.com")
            .tapCancelButton()
            .verifySitesVisible()
            .verifySiteNotPresent(withName: siteName)
    }

    func testDeleteSite() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855"))

        SitesScreen(app: app)
            .tapSite(id: siteID)
            .tapDeleteSiteButton()
            .tapConfirmDeleteSiteButton()
            .verifySitesVisible()
            .verifySiteNotPresent(withID: siteID)
    }

    func testDeleteSiteFromSitesList() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855"))

        SitesScreen(app: app)
            .verifySitesVisible()
            .swipLeftAndDeleteSite(withID: siteID)
            .verifySiteNotPresent(withID: siteID)
    }

}
