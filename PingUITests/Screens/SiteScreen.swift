//
//  SIteScreen.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

struct SiteScreen: Screen {

    let app: XCUIApplication

    private enum Identifiers {
        static let deleteSiteButton = "deleteSiteButton"
        static let confirmDeleteSiteButton = "confirmDeleteSiteButton"
        static let cancelDeleteSiteButton = "cancelDeleteSiteButton"
    }

    @discardableResult
    func verifyVisible(for siteName: String) -> Self {
        let view = app.navigationBars[siteName]
        XCTAssertTrue(view.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func tapDeleteSiteButton() -> SiteScreen {
        app.buttons[Identifiers.deleteSiteButton].tap()
        return self
    }

    @discardableResult
    func verifyRemoveAlertIsVisible() -> Self {
        let confirmAlert = app.alerts.firstMatch
        XCTAssertTrue(confirmAlert.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func tapConfirmDeleteSiteButton() -> SitesScreen {
        app.scrollViews.otherElements.buttons[Identifiers.confirmDeleteSiteButton].tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func tapCancelDeleteSiteButton() -> Self {
        app.alerts.firstMatch.buttons[Identifiers.cancelDeleteSiteButton].tap()
        return self
    }

}
