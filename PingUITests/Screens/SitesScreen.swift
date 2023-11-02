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
        static let view = "sidebar"
        static let addSiteButton = "addSiteToolbarButton"
        static let summaryNavigationLink = "summaryNavigationLink"
        static func siteNavigationLink(siteID: UUID) -> String {
            return "siteNavigationLink-\(siteID.uuidString)"
        }
        static let deleteButton = "Delete"
    }

    @discardableResult
    func verifySitesVisible() -> Self {
        XCTAssertTrue(sidebar.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func tapAddSiteButton() -> AddSiteScreen {
        addSiteButton.tap()
        return AddSiteScreen(app: app)
    }

    @discardableResult
    func tapSummary() -> SummaryScreen {
        summaryNavigationLink.tap()
        return SummaryScreen(app: app)
    }

    @discardableResult
    func tapSite(id: UUID) -> SiteScreen {
        siteNavigationLink(forSiteID: id).tap()
        return SiteScreen(app: app)
    }

    @discardableResult
    func swipLeftAndDeleteSite(withID id: UUID) -> SitesScreen {
        siteNavigationLink(forSiteID: id).swipeLeft()
        sideBarDeleteButton.tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func verifySitePresent(withName name: String) -> Self {
        XCTAssertTrue(siteNavigationLink(forSiteName: name).waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func verifySiteNotPresent(withName name: String) -> Self {
        XCTAssertFalse(siteNavigationLink(forSiteName: name).waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func verifySiteNotPresent(withID id: UUID) -> Self {
        XCTAssertFalse(siteNavigationLink(forSiteID: id).waitForExistence(timeout: 3))
        return self
    }

}

extension SitesScreen {

    private var sidebar: XCUIElement {
        #if os(macOS)
        app.outlines["Sidebar"]
        #else
        app.collectionViews[Identifiers.view]
        #endif
    }

    private var addSiteButton: XCUIElement {
        #if os(macOS)
        app.toolbars.children(matching: .button)["Add Site"].children(matching: .button)[Identifiers.addSiteButton]
        #else
        app.buttons[Identifiers.addSiteButton]
        #endif
    }

    private var summaryNavigationLink: XCUIElement {
        sidebar.buttons[Identifiers.summaryNavigationLink]
    }

    private func siteNavigationLink(forSiteID id: UUID) -> XCUIElement {
        sidebar.buttons[Identifiers.siteNavigationLink(siteID: id)]
    }

    private func siteNavigationLink(forSiteName name: String) -> XCUIElement {
        sidebar.buttons.staticTexts[name]
    }

    private var sideBarDeleteButton: XCUIElement {
        sidebar.buttons[Identifiers.deleteButton]
    }

}
