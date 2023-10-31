//
//  SiteDataSource.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol SiteDataSource {

    func fetch(withID id: Site.ID) async throws -> Site?

    func fetchAll() async throws -> [Site]

    func save(_ site: Site) async throws

    func `delete`(_ id: UUID) async throws

}
