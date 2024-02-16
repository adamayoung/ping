//
//  SitesScreen+SiteContextMenu.swift
//  PingUITests
//
//  Created by Adam Young on 14/11/2023.
//

import XCTest

extension SitesScreen {

    @available(macOS 14.0, *)
    struct SiteContextMenu: Menu {

        let app: XCUIApplication

        @discardableResult
        func selectAddToSiteGroupMenuItem() -> SitesScreen {
            addToSiteGroupMenuItem.tap()
            return SitesScreen(app: app)
        }

        @discardableResult
        func selectDeleteSiteMenuItem() -> SitesScreen {
            deleteSiteMenuItem.tap()
            return SitesScreen(app: app)
        }

    }

}

extension SitesScreen.SiteContextMenu {

    private enum Identifiers {
        static let addToSiteGroupMenuItem = "siteContentMenuAddToSiteGroupButton"
        static let deleteSiteMenuItem = "siteContentMenuDeleteButton"
    }

    @available(macOS 14.0, *)
    private var addToSiteGroupMenuItem: XCUIElement {
        app.menuItems[Identifiers.addToSiteGroupMenuItem]
    }

    @available(macOS 14.0, *)
    private var deleteSiteMenuItem: XCUIElement {
        app.menuItems[Identifiers.deleteSiteMenuItem]
    }

}
