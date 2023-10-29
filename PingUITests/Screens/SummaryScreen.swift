//
//  SummaryScreen.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

struct SummaryScreen: Screen {

    let app: XCUIApplication

    private enum Identifiers {
        static let deleteButton = "deleteButton"
    }

    @discardableResult
    func tapBackButton() -> SitesScreen {
        app.navigationBars.buttons.element(boundBy: 0).tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func tapDeleteButton() -> SitesScreen {
        app.buttons[Identifiers.deleteButton].tap()
        return SitesScreen(app: app)
    }

}
