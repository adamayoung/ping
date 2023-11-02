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
        static let view = "addSiteView"
        static let siteNameField = "siteNameField"
        static let siteURLField = "siteURLField"
        static let addButton = "addButton"
        static let cancelButton = "cancelButton"
    }

    @discardableResult
    func typeName(_ name: String) -> Self {
        siteNameField.tap()
        siteNameField.typeText(name)
        return self
    }

    @discardableResult
    func typeURL(_ url: String) -> Self {
        siteURLField.tap()
        siteURLField.typeText(url)
        return self
    }

    @discardableResult
    func verifyAddButtonIsDisabled() -> Self {
        XCTAssertFalse(addButton.isEnabled)
        return self
    }

    @discardableResult
    func verifyAddButtonIsEnabled() -> Self {
        XCTAssertTrue(addButton.isEnabled)
        return self
    }

    @discardableResult
    func tapAddButton() -> SitesScreen {
        addButton.tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func tapCancelButton() -> SitesScreen {
        cancelButton.tap()
        return SitesScreen(app: app)
    }

}

extension AddSiteScreen {

    private var siteNameField: XCUIElement {
        #if os(macOS)
        app.sheets.groups.textFields[Identifiers.siteNameField]
        #else
        app.textFields[Identifiers.siteNameField]
        #endif
    }

    private var siteURLField: XCUIElement {
        #if os(macOS)
        app.sheets.groups.textFields[Identifiers.siteURLField]
        #else
        app.textFields[Identifiers.siteURLField]
        #endif
    }

    private var addButton: XCUIElement {
        #if os(macOS)
        app.sheets.groups.buttons[Identifiers.addButton]
        #else
        app.buttons[Identifiers.addButton]
        #endif
    }

    private var cancelButton: XCUIElement {
        #if os(macOS)
        app.sheets.groups.buttons[Identifiers.cancelButton]
        #else
        app.buttons[Identifiers.cancelButton]
        #endif
    }

}
