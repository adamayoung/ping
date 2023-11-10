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
        nameField.tap()
        nameField.typeText(name)
        return self
    }

    @discardableResult
    func typeURL(_ url: String) -> Self {
        urlField.tap()
        urlField.typeText(url)
        return self
    }

    @discardableResult
    func typeTimeout(_ timeout: Int) -> Self {
        timeoutField.tap()
        timeoutField.typeText("\(timeout)")
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
    func assertAddButton(isEnabled: Bool, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertEqual(addButton.isEnabled, isEnabled, file: file, line: line)
        return self
    }

}

extension AddSiteScreen {

    private enum Identifiers {
        static let nameField = "siteNameField"
        static let urlField = "siteURLField"
        static let methodPicker = "siteMethodPicker"
        static let timeoutField = "siteTimeoutField"
        static let addButton = "addSiteButton"
        static let cancelButton = "cancelAddSiteButton"
    }

    private var nameField: XCUIElement {
        #if os(macOS)
        app.sheets.groups.textFields[Identifiers.nameField]
        #else
        app.textFields[Identifiers.nameField]
        #endif
    }

    private var urlField: XCUIElement {
        #if os(macOS)
        app.sheets.groups.textFields[Identifiers.urlField]
        #else
        app.textFields[Identifiers.urlField]
        #endif
    }

    private var methodPicker: XCUIElement {
        #if os(macOS)
        app.sheets.groups.pickers[Identifiers.methodPicker]
        #else
        app.pickers[Identifiers.methodPicker]
        #endif
    }

    private var timeoutField: XCUIElement {
        #if os(macOS)
        app.sheets.groups.textFields[Identifiers.siteTimeoutField]
        #else
        app.textFields[Identifiers.timeoutField]
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
