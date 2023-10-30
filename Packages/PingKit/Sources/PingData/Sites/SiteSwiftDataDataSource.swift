//
//  SiteSwiftDataDataSource.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain
import SwiftData

public actor SiteSwiftDataDataSource: SiteDataSource {

    private let model: BackgroundModelActor<Site>

    public init() {
        self.init(
            model: Factory.siteModel
        )
    }

    init(model: BackgroundModelActor<Site>) {
        self.model = model
    }

    public func site(withID id: PingDomain.Site.ID) async throws -> PingDomain.Site? {
        let predicate = #Predicate<Site> { site in
            site.id == id
        }

        guard let siteModel = try await model.fetch(predicate: predicate).first else {
            return nil
        }

        let site = PingDomain.Site(site: siteModel)
        return site
    }

    public func sites() async throws -> [PingDomain.Site] {
        let fetchDescriptor = FetchDescriptor<Site>(sortBy: [SortDescriptor(\.name)])
        let siteModels = try await model.fetch(descriptor: fetchDescriptor)

        let sites = siteModels.map(PingDomain.Site.init)

        return sites
    }

    public func save(_ site: PingDomain.Site) async throws {
        let siteModel = Site(site: site)

        try await model.save(siteModel)
    }

    public func `delete`(_ id: UUID) async throws {
        let predicate = #Predicate<Site> { site in
            site.id == id
        }
        try await model.delete(predicate: predicate)
    }

}
