//
//  ManageSiteGroupsScreen.swift
//  PingUITests
//
//  Created by Adam Young on 10/11/2023.
//

import XCTest

struct ManageSiteGroupsScreen: Screen {

    let app: XCUIApplication

    @discardableResult
    func tapSiteGroup(id: UUID) -> ManageSiteGroupsScreen {
        siteGroupNavigationLink(withID: id).tap()
        return self
    }

    @discardableResult
    func tapAddButton() -> AddSiteGroupScreen {
        addButton.tap()
        return AddSiteGroupScreen(app: app)
    }

    @discardableResult
    func tapCloseButton() -> SitesScreen {
        closeButton.tap()
        return SitesScreen(app: app)
    }

    @discardableResult
    func swipLeftAndDeleteSiteGroup(withID id: UUID) -> ManageSiteGroupsScreen {
        siteGroupNavigationLink(withID: id).swipeLeft()
        rowDeleteButton.tap()
        return self
    }

    @discardableResult
    func assertSiteGroup(withID id: UUID, isPresent: Bool, file: StaticString = #file, line: UInt = #line) -> Self {
        let navigationLink = siteGroupNavigationLink(withID: id)
        XCTAssertEqual(navigationLink.waitForExistence(timeout: 3), isPresent, file: file, line: line)
        return self
    }

    @discardableResult
    func assertSiteGroup(withName name: String, siteCount: Int = 0, isPresent: Bool, file: StaticString = #file,
                         line: UInt = #line) -> Self {
        let navigationLink = siteGroupNavigationLink(withName: name, siteCount: siteCount)
        XCTAssertEqual(navigationLink.waitForExistence(timeout: 3), isPresent, file: file, line: line)
        return self
    }

}

extension ManageSiteGroupsScreen {

    private enum Identifiers {
        static func siteGroupNavigationLink(siteGroupID: UUID) -> String {
            return "siteGroupNavigationLink-\(siteGroupID.uuidString)"
        }
        static let addButton = "addSiteGroupToolbarButton"
        static let closeButton = "closeSiteGroupToolbarButton"
        static let deleteButton = "Delete"
    }

    private func siteGroupNavigationLink(withID id: UUID) -> XCUIElement {
        #if os(macOS)
        app.sheets.tables.buttons[Identifiers.siteGroupNavigationLink(siteGroupID: id)]
        #else
        app.buttons[Identifiers.siteGroupNavigationLink(siteGroupID: id)]
        #endif
    }

    private func siteGroupNavigationLink(withName name: String, siteCount: Int) -> XCUIElement {
        #if os(macOS)
        let name = "\(name), \(siteCount)"
        return app.sheets.tables.buttons[name]
        #else
        return app.buttons.staticTexts[name]
        #endif
    }

    private var addButton: XCUIElement {
        #if os(macOS)
        app.sheets.toolbars.buttons[Identifiers.addButton]
        #else
        app.buttons[Identifiers.addButton]
        #endif
    }

    private var closeButton: XCUIElement {
        #if os(macOS)
        app.sheets.groups.buttons[Identifiers.closeButton]
        #else
        app.buttons[Identifiers.closeButton]
        #endif
    }

    private var rowDeleteButton: XCUIElement {
        app.buttons[Identifiers.deleteButton]
    }

}
