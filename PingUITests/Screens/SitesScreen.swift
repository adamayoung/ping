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
        static let delete = "Delete"
    }

    private var sidebar: XCUIElement {
        app.collectionViews[Identifiers.view]
    }

    @discardableResult
    func verifySitesVisible() -> Self {
        XCTAssertTrue(sidebar.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func tapAddSiteButton() -> AddSiteScreen {
        let button = app.buttons[Identifiers.addSiteButton]
        button.tap()
        return AddSiteScreen(app: app)
    }

    @discardableResult
    func tapSummary() -> SummaryScreen {
        let button = sidebar.buttons[Identifiers.summaryNavigationLink]
        button.tap()
        return SummaryScreen(app: app)
    }

    @discardableResult
    func tapSite(id: UUID) -> SiteScreen {
        let button = sidebar.buttons[Identifiers.siteNavigationLink(siteID: id)]
        button.tap()
        return SiteScreen(app: app)
    }

    @discardableResult
    func swipLeftAndDeleteSite(withID id: UUID) -> SitesScreen {
        let button = sidebar.buttons[Identifiers.siteNavigationLink(siteID: id)]
        button.swipeLeft()
        let deleteButton = sidebar.buttons[Identifiers.delete]
        deleteButton.tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func verifySite(withName name: String) -> Self {
        let site = sidebar.buttons.staticTexts[name]
        XCTAssertTrue(site.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func verifySiteNotPresent(withName name: String) -> Self {
        let site = sidebar.buttons.staticTexts[name]
        XCTAssertFalse(site.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func verifySiteNotPresent(withID id: UUID) -> Self {
        let button = sidebar.buttons[Identifiers.siteNavigationLink(siteID: id)]
        XCTAssertFalse(button.waitForExistence(timeout: 3))
        return self
    }

}
