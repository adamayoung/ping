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

    func testFetchReturnsSetActionWithSites() async {
        let state = SitesState()
        let action = SitesAction.fetch
        let expectedSites = [
            Site(
                id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
                name: "Google",
                url: URL(string: "https://www.google.com")!
            ),
            Site(
                id: UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!,
                name: "GitHub",
                url: URL(string: "https://github.com")!
            ),
            Site(
                id: UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!,
                name: "Twitter",
                url: URL(string: "https://twitter.com")!
            )
        ]
        dependencies.sitesResult = .success(expectedSites)

        let newAction = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        switch newAction {
        case .set(let sites):
            XCTAssertEqual(sites, expectedSites)

        default:
            XCTFail("Unexpected action returned")
        }
    }

    func testFetchWhenErrorReturnsSetActionWithEmptySites() async {
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

    func testAddReturnsFetchAction() async {
        let state = SitesState()
        let expectedSite = Site(
            id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
            name: "Google",
            url: URL(string: "https://www.google.com")!
        )
        let action = SitesAction.add(expectedSite)

        let newAction = await sitesInterceptor(state: state, action: action, dependencies: dependencies)

        switch newAction {
        case .fetch:
            XCTAssertTrue(true)

        default:
            XCTFail("Unexpected action returned")
        }
    }

}

extension SitesInterceptorTests {

    struct SitesInterceptorError: Error {

        let id = UUID()

    }

}
