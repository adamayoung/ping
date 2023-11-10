//
//  SIteScreen.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

struct SiteScreen: Screen {

    let app: XCUIApplication

    @discardableResult
    func tapDeleteSiteButton() -> SiteScreen {
        deleteButton.tap()
        return self
    }

    @discardableResult
    func tapConfirmDeleteSiteButton() -> SitesScreen {
        confirmDeleteSiteButton.tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func tapCancelDeleteSiteButton() -> Self {
        cancelDeleteSiteButton.tap()
        return self
    }

    @discardableResult
    func assertScreenVisible(for siteName: String, file: StaticString = #file, line: UInt = #line) -> Self {
        let view = app.navigationBars[siteName]
        XCTAssertTrue(view.waitForExistence(timeout: 3), file: file, line: line)
        return self
    }

    @discardableResult
    func verifyRemoveAlertIsVisible(file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(alert.waitForExistence(timeout: 3), file: file, line: line)
        return self
    }

}

extension SiteScreen {

    private enum Identifiers {
        static let deleteSiteButton = "deleteSiteButton"
        static let confirmDeleteSiteButton = "confirmDeleteSiteButton"
        static let cancelDeleteSiteButton = "cancelDeleteSiteButton"
    }

    private var alert: XCUIElement {
        app.alerts.firstMatch
    }

    private var deleteButton: XCUIElement {
        #if os(macOS)
        app.buttons[Identifiers.deleteSiteButton]
        #else
        app.buttons[Identifiers.deleteSiteButton]
        #endif
    }

    private var confirmDeleteSiteButton: XCUIElement {
        app.alerts.firstMatch.buttons[Identifiers.confirmDeleteSiteButton]
    }

    private var cancelDeleteSiteButton: XCUIElement {
        app.alerts.firstMatch.buttons[Identifiers.cancelDeleteSiteButton]
    }

}
