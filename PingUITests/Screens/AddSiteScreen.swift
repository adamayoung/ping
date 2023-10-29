//
//  AppSiteScreen.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

struct AddSiteScreen: Screen {

    let app: XCUIApplication

    private enum Identifiers {
        static let siteNameField = "siteNameField"
        static let siteURLField = "siteURLField"
        static let addButton = "addButton"
        static let cancelButton = "cancelButton"
    }

    @discardableResult
    func typeName(_ name: String) -> Self {
        let nameField = app.textFields[Identifiers.siteNameField]
        nameField.tap()
        nameField.typeText(name)
        return self
    }

    @discardableResult
    func typeURL(_ url: String) -> Self {
        let urlField = app.textFields[Identifiers.siteURLField]
        urlField.tap()
        urlField.typeText(url)
        return self
    }

    @discardableResult
    func verifyAddButtonIsDisabled() -> Self {
        let button = app.buttons[Identifiers.addButton]
        XCTAssertFalse(button.isEnabled)
        return self
    }

    @discardableResult
    func verifyAddButtonIsEnabled() -> Self {
        let button = app.buttons[Identifiers.addButton]
        XCTAssertTrue(button.isEnabled)
        return self
    }

    @discardableResult
    func tapAddButton() -> SitesScreen {
        let button = app.buttons[Identifiers.addButton]
        button.tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func tapCancelButton() -> SitesScreen {
        let button = app.buttons[Identifiers.cancelButton]
        button.tap()
        return SitesScreen(app: app)
    }

}
