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

    private let modelActor: BackgroundModelActor

    public init(inMemory: Bool) {
        self.init(modelActor: Factory.modelActor(inMemory: inMemory))
    }

    init(modelActor: BackgroundModelActor) {
        self.modelActor = modelActor
    }

    public func fetch(withID id: PingDomain.Site.ID) async throws -> PingDomain.Site? {
        let predicate = #Predicate<Site> { $0.id == id }
        let fetchDescriptor = FetchDescriptor<Site>(predicate: predicate)

        guard let siteModel = try await modelActor.fetch(fetchDescriptor).first else {
            return nil
        }

        let site = PingDomain.Site(site: siteModel)
        return site
    }

    public func fetchAll() async throws -> [PingDomain.Site] {
        let fetchDescriptor = FetchDescriptor<Site>(sortBy: [SortDescriptor(\.name)])
        let siteModels = try await modelActor.fetch(fetchDescriptor)

        let sites = siteModels.map(PingDomain.Site.init)

        return sites
    }

    public func save(_ site: PingDomain.Site) async throws {
        let siteModel = Site(site: site)
        try await modelActor.insert(siteModel)
        try await modelActor.save()
    }

    public func `delete`(_ id: UUID) async throws {
        let predicate = #Predicate<Site> { $0.id == id }
        try await modelActor.delete(predicate)
        try await modelActor.save()
    }

}
