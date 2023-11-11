//
//  AddSiteTests.swift
//  PingUITests
//
//  Created by Adam Young on 26/10/2023.
//

import XCTest

final class AddAndRemoveSitesTests: UITestCaseBase {

    func testAddSite() {
        let siteName = "Test Site"

        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .tapAddSiteButton()
            .assertAddButton(isEnabled: false)
            .typeName(siteName)
            .typeURL("www.domain.com")
            .assertAddButton(isEnabled: true)
            .tapAddButton()
            .assertSite(withName: siteName, isPresent: true)
    }

    func testa() {
        
        let swiftuiSubscriptionviewCombineAnypublisherPingSitestatusresultSwiftNeverPingContentview1Appwindow1Window = XCUIApplication()/*@START_MENU_TOKEN@*/.windows["SwiftUI.SubscriptionView<Combine.AnyPublisher<Ping.SiteStatusResult, Swift.Never>, Ping.ContentView>-1-AppWindow-1"]/*[[".windows[\"Summary\"]",".windows[\"SwiftUI.SubscriptionView<Combine.AnyPublisher<Ping.SiteStatusResult, Swift.Never>, Ping.ContentView>-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let toolbarsQuery = swiftuiSubscriptionviewCombineAnypublisherPingSitestatusresultSwiftNeverPingContentview1Appwindow1Window.toolbars
        toolbarsQuery/*@START_MENU_TOKEN@*/.popUpButtons["sitesActionToolbarMenuButton"]/*[[".groups",".popUpButtons[\"More\"]",".popUpButtons[\"sitesActionToolbarMenuButton\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.click()
        toolbarsQuery/*@START_MENU_TOKEN@*/.menuItems["addSiteToolbarMenuButton"]/*[[".groups",".menus",".menuItems[\"Add Site\"]",".menuItems[\"addSiteToolbarMenuButton\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.click()
        swiftuiSubscriptionviewCombineAnypublisherPingSitestatusresultSwiftNeverPingContentview1Appwindow1Window.sheets/*@START_MENU_TOKEN@*/.groups/*[[".scrollViews.groups",".groups"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["siteURLField"].click()
        swiftuiSubscriptionviewCombineAnypublisherPingSitestatusresultSwiftNeverPingContentview1Appwindow1Window/*@START_MENU_TOKEN@*/.outlines["sidebar"]/*[[".splitGroups[\"SwiftUI.SubscriptionView<Combine.AnyPublisher<Ping.SiteStatusResult, Swift.Never>, Ping.ContentView>-1-AppWindow-1, SidebarNavigationSplitView\"]",".groups",".scrollViews",".outlines[\"Sidebar\"]",".outlines[\"sidebar\"]"],[[[-1,4],[-1,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/.children(matching: .outlineRow).element(boundBy: 0).children(matching: .cell).element.typeText("https://www.google.com")
        
    }

    func testCannotAddSiteWithInvalidURL() {
        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .tapAddSiteButton()
            .assertAddButton(isEnabled: false)
            .typeName("Test Site")
            .typeURL("aaa")
            .assertAddButton(isEnabled: false)
    }

    func testCancellingAddNewSite() {
        let siteName = "Test Site"

        initialScreen
            .verifySitesVisible()
            .tapSitesActionMenuButton()
            .tapAddSiteButton()
            .typeName(siteName)
            .typeURL("www.domain.com")
            .tapCancelButton()
            .verifySitesVisible()
            .assertSite(withName: siteName, isPresent: false)
    }

    #if os(iOS)
    func testDeleteSiteFromSitesList() {
        let siteID = UUID.googleSite

        initialScreen
            .verifySitesVisible()
            .deleteSite(withID: siteID)
            .assertSite(withID: siteID, isPresent: false)
    }
    #endif

}
