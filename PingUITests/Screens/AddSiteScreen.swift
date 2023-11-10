//
//  AppSiteScreen.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

struct AddSiteScreen: Screen {

    let app: XCUIApplication

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
    func typeTimeout(_ timeout: Int) -> Self {
        siteTimeoutField.tap()
        siteTimeoutField.typeText("\(timeout)")
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

    @discardableResult
    func assertAddButtonIsDisabled(file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertFalse(addButton.isEnabled, file: file, line: line)
        return self
    }

    @discardableResult
    func assertAddButtonIsEnabled(file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(addButton.isEnabled, file: file, line: line)
        return self
    }

}

extension AddSiteScreen {

    private enum Identifiers {
        static let view = "addSiteView"
        static let siteNameField = "siteNameField"
        static let siteURLField = "siteURLField"
        static let siteMethodPicker = "siteMethodPicker"
        static let siteTimeoutField = "siteTimeoutField"
        static let addButton = "addButton"
        static let cancelButton = "cancelButton"
    }

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

    private var siteTimeoutField: XCUIElement {
        #if os(macOS)
        app.sheets.groups.textFields[Identifiers.siteTimeoutField]
        #else
        app.textFields[Identifiers.siteTimeoutField]
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
