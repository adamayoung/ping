//
//  SitesMockDependencies.swift
//  PinkKitTests
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingKit

final class SitesMockDependencies: SitesDependencies {

    var sitesResult: Result<[Site], Error> = .success([])

    func sites() async throws -> [Site] {
        try sitesResult.get()
    }

    func add(site: PingKit.Site) async throws {

    }

    func remove(id: PingKit.Site.ID) async throws {

    }

}
