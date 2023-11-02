//
//  SitesInterceptorTests.swift
//  PingKitTests
//
//  Created by Adam Young on 27/10/2023.
//

@testable import PingKit
import XCTest

final class SitesInterceptorTests: XCTestCase {

    var dependencies: SitesMockDependencies!

    override func setUp() {
        super.setUp()
        dependencies = SitesMockDependencies()
    }

    override func tearDown() {
        dependencies = nil
        super.tearDown()
    }

    @MainActor
    func testFetchActionReturnsSetActionWithSites() async {
        let state = SitesState()
        let action = SitesAction.fetch
        let expectedSites = [Site.google, Site.gitHub, Site.twitter]
        dependencies.sitesResult = .success(expectedSites)

        let newAction = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        switch newAction {
        case .set(let sites):
            XCTAssertEqual(sites, expectedSites)

        default:
            XCTFail("Unexpected action returned")
        }
    }

    @MainActor
    func testFetchActionWhenErrorReturnsSetActionWithEmptySites() async {
        let state = SitesState()
        let action = SitesAction.fetch
        let error = SitesInterceptorError()
        dependencies.sitesResult = .failure(error)

        let newAction = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        switch newAction {
        case .set(let sites):
            XCTAssertTrue(sites.isEmpty)

        default:
            XCTFail("Unexpected action returned")
        }
    }

    @MainActor
    func testAddActionAddsSite() async {
        let state = SitesState()
        let expectedSite = Site.google
        let action = SitesAction.add(expectedSite)

        _ = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        XCTAssertEqual(dependencies.lastAddedSite, expectedSite)
    }

    @MainActor
    func testAddActionReturnsFetchAction() async {
        let state = SitesState()
        let action = SitesAction.add(.google)

        let newAction = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        switch newAction {
        case .fetch:
            XCTAssertTrue(true)

        default:
            XCTFail("Unexpected action returned")
        }
    }

    func testRemoveActionRemovesSite() async {
        let state = SitesState()
        let expectedSite = Site.google
        let action = SitesAction.remove(expectedSite)

        _ = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        XCTAssertEqual(dependencies.lastRemovedSiteID, expectedSite.id)
    }

    @MainActor
    func testRemoveActionReturnsFetchAction() async {
        let state = SitesState()
        let action = SitesAction.remove(.google)

        let newAction = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        switch newAction {
        case .fetch:
            XCTAssertTrue(true)

        default:
            XCTFail("Unexpected action returned")
        }
    }

    @MainActor
    func testSetActionReturnsNil() async {
        let state = SitesState()
        let action = SitesAction.set([.google])

        let newAction = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        XCTAssertNil(newAction)
    }

}

extension SitesInterceptorTests {

    struct SitesInterceptorError: Error {

        let id = UUID()

    }

}
