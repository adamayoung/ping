//
//  AddSiteGroupScreen.swift
//  PingUITests
//
//  Created by Adam Young on 10/11/2023.
//

import XCTest

struct AddSiteGroupScreen: Screen {

    let app: XCUIApplication

    @discardableResult
    func typeName(_ name: String) -> Self {
        nameField.tap()
        nameField.typeText(name)
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

extension AddSiteGroupScreen {

    private enum Identifiers {
        static let nameField = "siteGroupNameField"
        static let addButton = "addSiteGroupButton"
        static let cancelButton = "cancelAddSiteGroupButton"
    }

    private var nameField: XCUIElement {
        #if os(macOS)
        app.sheets.groups.textFields[Identifiers.nameField]
        #else
        app.textFields[Identifiers.nameField]
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
