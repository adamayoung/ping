//
//  AddSiteScreen+MethodPicker.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

extension AddSiteScreen {

    struct MethodPicker {

        let app: XCUIApplication

        @discardableResult
        func taptMethodItem(_ method: MethodPickerItem) -> AddSiteScreen {
            let pickerItem = methodPickerItem(method)
            pickerItem.tap()
            return AddSiteScreen(app: app)
        }

    }

}

extension AddSiteScreen.MethodPicker {

    private enum Identifiers {
        static let methodPicker = "siteMethodPicker"
        static func methodPickerItem(withMethod method: MethodPickerItem) -> String {
            "siteMethodPickerItem-\(method.rawValue)"
        }
    }

    private var methodPicker: XCUIElement {
        #if os(macOS)
        app.sheets.groups.popUpButtons[Identifiers.methodPicker]
        #else
        app.pickers[Identifiers.methodPicker]
        #endif
    }

    private func methodPickerItem(_ method: MethodPickerItem) -> XCUIElement {
        let itemID = Identifiers.methodPickerItem(withMethod: method)
        return methodPicker.menuItems[itemID]
    }

}

extension AddSiteScreen.MethodPicker {

    enum MethodPickerItem: String {
        case get = "GET"
    }

}
