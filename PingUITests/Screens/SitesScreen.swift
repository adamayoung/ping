//
//  SitesScreen.swift
//  PingUITests
//
//  Created by Adam Young on 27/10/2023.
//

import XCTest

struct SitesScreen: Screen {

    let app: XCUIApplication

    private enum Identifiers {
        static let view = "Sidebar"
        static let addSiteButton = "addSiteToolbarButton"
        static let summaryNavigationLink = "summaryNavigationLink"
        static func siteNavigationLink(siteID: UUID) -> String {
            return "siteNavigationLink-\(siteID.uuidString)"
        }
    }

    @discardableResult
    func verifySitesVisible() -> Self {
        let view = app.collectionViews[Identifiers.view]
        XCTAssertTrue(view.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func tapAddSiteButton() -> AddSiteScreen {
        app.buttons[Identifiers.addSiteButton].firstMatch.tap()
        return AddSiteScreen(app: app)
    }

    @discardableResult
    func tapSummary() -> SummaryScreen {
        app.buttons[Identifiers.summaryNavigationLink].tap()
        return SummaryScreen(app: app)
    }

    @discardableResult
    func tapSite(id: UUID) -> SiteScreen {
        app.buttons[Identifiers.siteNavigationLink(siteID: id)].tap()
        return SiteScreen(app: app)
    }

    @discardableResult
    func verifySite(withName name: String) -> Self {
        let site = app.staticTexts[name]
        XCTAssertTrue(site.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func verifySiteNotPresent(withName name: String) -> Self {
        let site = app.buttons.staticTexts[name]
        XCTAssertFalse(site.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func verifySiteNotPresent(withID id: UUID) -> Self {
        let button = app.buttons[Identifiers.siteNavigationLink(siteID: id)]
        XCTAssertFalse(button.waitForExistence(timeout: 3))
        return self
    }

}
