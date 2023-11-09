//
//  SitesDependencies.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public protocol SitesDependencies {

    func sites() async throws -> [Site]

    func add(_ site: Site) async throws

    func remove(_ site: Site) async throws

}
