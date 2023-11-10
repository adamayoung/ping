//
//  SummaryScreen.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

struct SummaryScreen: Screen {

    let app: XCUIApplication

    @discardableResult
    func tapBackButton() -> SitesScreen {
        backButton.tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func tapDeleteButton() -> SitesScreen {
        deleteButton.tap()
        return SitesScreen(app: app)
    }

}

extension SummaryScreen {

    private enum Identifiers {
        static let deleteButton = "deleteButton"
    }

    private var backButton: XCUIElement {
        #if os(macOS)
        app.sheets.groups.buttons[Identifiers.deleteButton]
        #else
        app.navigationBars.buttons.element(boundBy: 0)
        #endif
    }

    private var deleteButton: XCUIElement {
        #if os(macOS)
        app.sheets.groups.buttons[Identifiers.deleteButton]
        #else
        app.buttons[Identifiers.deleteButton]
        #endif
    }

}
