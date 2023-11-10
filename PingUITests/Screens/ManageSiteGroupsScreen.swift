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
    func assertSiteGroup(withName name: String, isPresent: Bool, file: StaticString = #file,
                         line: UInt = #line) -> Self {
        let navigationLink = siteGroupNavigationLink(withName: name)
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
        app.buttons[Identifiers.siteGroupNavigationLink(siteGroupID: id)]
    }

    private func siteGroupNavigationLink(withName name: String) -> XCUIElement {
        app.buttons.staticTexts[name]
    }

    private var addButton: XCUIElement {
        app.buttons[Identifiers.addButton]
    }

    private var closeButton: XCUIElement {
        app.buttons[Identifiers.closeButton]
    }

    private var rowDeleteButton: XCUIElement {
        app.buttons[Identifiers.deleteButton]
    }

}
