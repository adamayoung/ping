//
//  UITestCase.swift
//  PingUITests
//
//  Created by Adam Young on 28/10/2023.
//

import XCTest

class UITestCaseBase: XCTestCase {

    private var app: XCUIApplication!

    private(set) lazy var initialScreen = {
        SitesScreen(app: app)
    }()

    override func setUp() {
        #if os(iOS)
        XCUIDevice.shared.orientation = .portrait
        #endif
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
    }

    override func tearDown() {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .deleteOnSuccess
        add(attachment)
        app.terminate()
    }

}
