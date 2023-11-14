//
//  SitesScreen+ActionMenu.swift
//  PingUITests
//
//  Created by Adam Young on 10/11/2023.
//

import XCTest

extension SitesScreen {

    struct ActionMenu: Menu {

        let app: XCUIApplication

        @discardableResult
        func selectRefreshSiteStatusesMenuItem() -> SitesScreen {
            refreshSiteStatusesButton.tap()
            return SitesScreen(app: app)
        }

        @discardableResult
        func selectAddSiteMenuItem() -> AddSiteScreen {
            addSiteButton.tap()
            return AddSiteScreen(app: app)
        }

        @discardableResult
        func selectAddSiteGroupMenuItem() -> AddSiteGroupScreen {
            addSiteGroupButton.tap()
            return AddSiteGroupScreen(app: app)
        }

        @discardableResult
        func selectManageSiteGroupsMenuItem() -> ManageSiteGroupsScreen {
            manageSiteGroupsButton.tap()
            return ManageSiteGroupsScreen(app: app)
        }

    }

}

extension SitesScreen.ActionMenu {

    private enum Identifiers {
        static let refreshSiteStatusesToolbarButton = "refreshSiteStatusesToolbarButton"
        static let addSiteToolbarMenuButton = "addSiteToolbarMenuButton"
        static let addSiteGroupToolbarMenuButton = "addSiteGroupToolbarMenuButton"
        static let manageSiteGroupsToolbarMenuButton = "manageSiteGroupsToolbarMenuButton"
    }

    private var refreshSiteStatusesButton: XCUIElement {
        #if os(macOS)
        app.toolbars.children(matching: .button)["Add Site"]
            .children(matching: .button)[Identifiers.refreshSiteStatusesToolbarButton]
        #else
        app.buttons[Identifiers.refreshSiteStatusesToolbarButton]
        #endif
    }

    private var addSiteButton: XCUIElement {
        #if os(macOS)
        app.toolbars.menuItems[Identifiers.addSiteToolbarMenuButton]
        #else
        app.buttons[Identifiers.addSiteToolbarMenuButton]
        #endif
    }

    private var addSiteGroupButton: XCUIElement {
        #if os(macOS)
        app.toolbars.menuItems[Identifiers.addSiteGroupToolbarMenuButton]
        #else
        app.buttons[Identifiers.addSiteGroupToolbarMenuButton]
        #endif
    }

    private var manageSiteGroupsButton: XCUIElement {
        #if os(macOS)
        app.toolbars.menuItems[Identifiers.manageSiteGroupsToolbarMenuButton]
        #else
        app.buttons[Identifiers.manageSiteGroupsToolbarMenuButton]
        #endif
    }

}
