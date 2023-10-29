//
//  SitesReducerTests.swift
//  PingKitTests
//
//  Created by Adam Young on 27/10/2023.
//

@testable import PingKit
import XCTest

final class SitesReducerTests: XCTestCase {

    func testSetSetsSites() {
        let state = SitesState()
        let expectedSites = [githubSite, googleSite, twitterSite]
        let action = SitesAction.set(expectedSites)

        let newState = sitesReducer(state: state, action: action)

        XCTAssertEqual(newState.all, expectedSites)
    }

    func testAddAddsSiteToAllSites() {
        let state = SitesState(
            all: [googleSite, twitterSite]
        )
        let expectedSites = [googleSite, twitterSite, microsoftSite]
        let action = SitesAction.add(microsoftSite)

        let newState = sitesReducer(state: state, action: action)

        XCTAssertEqual(newState.all, expectedSites)
    }

    func testRemoveRemovesSiteFromAllSites() {
        let state = SitesState(
            all: [githubSite, googleSite, twitterSite]
        )
        let expectedSites = [githubSite, twitterSite]
        let action = SitesAction.remove(googleSite)

        let newState = sitesReducer(state: state, action: action)

        XCTAssertEqual(newState.all, expectedSites)
    }

}

extension SitesReducerTests {

    var googleSite: Site {
        Site(
            id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
            name: "Google",
            url: URL(string: "https://www.google.com")!
        )
    }

    var twitterSite: Site {
        Site(
            id: UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!,
            name: "Twitter",
            url: URL(string: "https://twitter.com")!
        )
    }

    var githubSite: Site {
        Site(
            id: UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!,
            name: "GitHub",
            url: URL(string: "https://github.com")!
        )
    }

    var microsoftSite: Site {
        Site(
            id: UUID(uuidString: "D86808FA-E0BE-467D-BB38-7092FDD95A5C")!,
            name: "Microsoft",
            url: URL(string: "https://microsoft.com")!
        )
    }

}
