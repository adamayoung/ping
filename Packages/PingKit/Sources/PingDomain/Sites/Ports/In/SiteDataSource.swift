//
//  SiteDataSource.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol SiteDataSource {

    func sites() async throws -> [Site]

    func save(_ site: Site) async throws

    func `delete`(_ id: UUID) async throws

}
