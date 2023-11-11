//
//  AddSiteScreen+SiteGroupPicker.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

extension AddSiteScreen {

    struct SiteGroupPicker {

        let app: XCUIApplication

        @discardableResult
        func tapSiteGroupItem(withID id: UUID) -> AddSiteScreen {
            let pickerItem = siteGroupPickerItem(withID: id)
            pickerItem.tap()
            return AddSiteScreen(app: app)
        }

        @discardableResult
        func tapSiteGroupItem(withName name: String) -> AddSiteScreen {
            let pickerItem = siteGroupPickerItem(withName: name)
            pickerItem.tap()
            return AddSiteScreen(app: app)
        }

    }

}

extension AddSiteScreen.SiteGroupPicker {

    private enum Identifiers {
        static let siteGroupPicker = "siteGroupPicker"
        static func siteGroupPickerItem(withID id: UUID) -> String {
            "siteSiteGroupPickerItem-\(id.uuidString)"
        }
    }

    private var siteGroupPicker: XCUIElement {
        #if os(macOS)
        app.sheets.groups.popUpButtons[Identifiers.siteGroupPicker]
        #else
        app.pickers[Identifiers.siteGroupPicker]
        #endif
    }

    private func siteGroupPickerItem(withID id: UUID) -> XCUIElement {
        let itemID = Identifiers.siteGroupPickerItem(withID: id)
        return siteGroupPicker.menuItems[itemID]
    }

    private func siteGroupPickerItem(withName name: String) -> XCUIElement {
        return siteGroupPicker.menuItems.staticTexts[name]
    }

}
