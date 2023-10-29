//
//  SitesReducerTests.swift
//  PingKitTests
//
//  Created by Adam Young on 27/10/2023.
//

@testable import PingKit
import XCTest

final class SitesReducerTests: XCTestCase {

    func testFetchActionDoesNotAlterState() {
        let state = SitesState()
        let action = SitesAction.fetch

        let newState = sitesReducer(state: state, action: action)

        XCTAssertEqual(newState, state)
    }

    func testSetActionSetsSites() {
        let state = SitesState()
        let expectedSites = [Site.gitHub, Site.google, Site.twitter]
        let action = SitesAction.set(expectedSites)

        let newState = sitesReducer(state: state, action: action)

        XCTAssertEqual(newState.all, expectedSites)
    }

    func testAddActionDoesNotAlterState() {
        let state = SitesState()
        let action = SitesAction.add(.gitHub)

        let newState = sitesReducer(state: state, action: action)

        XCTAssertEqual(newState, state)
    }

    func testRemoveActionDoesNotAlterState() {
        let state = SitesState()
        let action = SitesAction.remove(.gitHub)

        let newState = sitesReducer(state: state, action: action)

        XCTAssertEqual(newState, state)
    }

}
