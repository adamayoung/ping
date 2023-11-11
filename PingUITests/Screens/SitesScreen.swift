//
//  SitesScreen.swift
//  PingUITests
//
//  Created by Adam Young on 27/10/2023.
//

import XCTest

struct SitesScreen: Screen {

    let app: XCUIApplication

    @discardableResult
    func verifySitesVisible() -> Self {
        XCTAssertTrue(sidebar.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func tapSitesActionMenuButton() -> SitesScreen.ActionMenu {
        actionToolbarMenuButton.tap()
        return SitesScreen.ActionMenu(app: app)
    }

    @discardableResult
    func tapSummary() -> SummaryScreen {
        summaryNavigationLink.tap()
        return SummaryScreen(app: app)
    }

    @discardableResult
    func tapSite(id: UUID) -> SiteScreen {
        siteNavigationLink(withID: id).tap()
        return SiteScreen(app: app)
    }

    @discardableResult
    func deleteSite(withID id: UUID) -> SitesScreen {
        siteNavigationLink(withID: id).swipeLeft()
        rowDeleteButton.tap()
        return self
    }

    @discardableResult
    func assertSite(withID id: UUID, isPresent: Bool, file: StaticString = #file, line: UInt = #line) -> Self {
        let navigationLink = siteNavigationLink(withID: id)
        XCTAssertEqual(navigationLink.waitForExistence(timeout: 3), isPresent, file: file, line: line)
        return self
    }

    @discardableResult
    func assertSite(withName name: String, isPresent: Bool, file: StaticString = #file, line: UInt = #line) -> Self {
        let navigationLink = siteNavigationLink(withName: name)
        XCTAssertEqual(navigationLink.waitForExistence(timeout: 3), isPresent, file: file, line: line)
        return self
    }

}

extension SitesScreen {

    private enum Identifiers {
        static let view = "sidebar"
        static let actionToolbarMenuButton = "sitesActionToolbarMenuButton"
        static let summaryNavigationLink = "summaryNavigationLink"
        static func siteNavigationLink(siteID: UUID) -> String {
            return "siteNavigationLink-\(siteID.uuidString)"
        }
        static let deleteButton = "Delete"
    }

    private var sidebar: XCUIElement {
        #if os(macOS)
        app.outlines["Sidebar"]
        #else
        app.collectionViews[Identifiers.view]
        #endif
    }

    private var actionToolbarMenuButton: XCUIElement {
        #if os(macOS)
        app.toolbars.popUpButtons[Identifiers.actionToolbarMenuButton]
        #else
        app.buttons[Identifiers.actionToolbarMenuButton]
        #endif
    }

    private var summaryNavigationLink: XCUIElement {
        sidebar.buttons[Identifiers.summaryNavigationLink]
    }

    private func siteNavigationLink(withID id: UUID) -> XCUIElement {
        sidebar.buttons[Identifiers.siteNavigationLink(siteID: id)]
    }

    private func siteNavigationLink(withName name: String) -> XCUIElement {
        #if os(macOS)
        sidebar.buttons[name]
        #else
        sidebar.buttons.staticTexts[name]
        #endif
    }

    private var rowDeleteButton: XCUIElement {
        sidebar.buttons[Identifiers.deleteButton]
    }

}
