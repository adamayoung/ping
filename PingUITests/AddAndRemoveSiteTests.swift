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
            .assertAddButtonIsDisabled()
            .typeName(siteName)
            .typeURL("https://www.domain.com")
            .assertAddButtonIsEnabled()
            .tapAddButton()
            .assertSitePresent(withName: siteName)
    }

    func testCannotAddSiteWithInvalidURL() {
        SitesScreen(app: app)
            .verifySitesVisible()
            .tapAddSiteButton()
            .assertAddButtonIsDisabled()
            .typeName("Test Site")
            .typeURL("aaa")
            .assertAddButtonIsDisabled()
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
            .assertSiteNotPresent(withName: siteName)
    }

    func testDeleteSiteFromSitesList() throws {
        let siteID = try XCTUnwrap(UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855"))

        SitesScreen(app: app)
            .verifySitesVisible()
            .swipLeftAndDeleteSite(withID: siteID)
            .assertSiteNotPresent(withID: siteID)
    }

}
