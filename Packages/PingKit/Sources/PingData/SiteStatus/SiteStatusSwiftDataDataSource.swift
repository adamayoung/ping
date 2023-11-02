//
//  SiteStatusSwiftDataDataSource.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain
import SwiftData

public actor SiteStatusSwiftDataDataSource: SiteStatusDataSource {

    private let modelActor: BackgroundModelActor

    public init(inMemory: Bool) {
        self.init(modelActor: Factory.modelActor(inMemory: inMemory))
    }

    init(modelActor: BackgroundModelActor) {
        self.modelActor = modelActor
    }

    public func fetchAll(for siteID: PingDomain.Site.ID) async throws -> [PingDomain.SiteStatus] {
        let predicate = #Predicate<SiteStatus> { $0.site?.id == siteID }
        let sortDescriptors: [SortDescriptor<SiteStatus>] = [SortDescriptor(\.timestamp)]
        let fetchDescriptor = FetchDescriptor<SiteStatus>(predicate: predicate, sortBy: sortDescriptors)
        let siteStatusModels = try await modelActor.fetch(fetchDescriptor)

        let siteStatuses = siteStatusModels.compactMap(PingDomain.SiteStatus.init)

        return siteStatuses
    }

    public func fetchAllLatest() async throws -> [PingDomain.Site.ID: PingDomain.SiteStatus] {
        let fetchDescriptor = FetchDescriptor<Site>()
        let sites = try await modelActor.fetch(fetchDescriptor)
        var results: [PingDomain.Site.ID: PingDomain.SiteStatus] = [:]
        for site in sites {
            guard let siteStatusModel = (site.statuses.sorted { $0.timestamp > $1.timestamp }).first else {
                continue
            }

            let siteStatus = PingDomain.SiteStatus(siteStatus: siteStatusModel)
            results[site.id] = siteStatus
        }

        return results
    }

    public func fetch(latestFor siteID: PingDomain.Site.ID) async throws -> PingDomain.SiteStatus? {
        let predicate = #Predicate<SiteStatus> { $0.site?.id == siteID }
        var fetchDescriptor = FetchDescriptor<SiteStatus>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        fetchDescriptor.fetchLimit = 1
        guard let siteStatusModel = try await modelActor.fetch(fetchDescriptor).first else {
            return nil
        }

        let siteStatus = PingDomain.SiteStatus(siteStatus: siteStatusModel)

        return siteStatus
    }

    public func save(siteStatus: PingDomain.SiteStatus, for siteID: PingDomain.Site.ID) async throws {
        let predicate = #Predicate<Site> { $0.id == siteID }
        let fetchDescriptor = FetchDescriptor<Site>(predicate: predicate)
        guard let site = try await modelActor.fetch(fetchDescriptor).first else {
            return
        }

        let siteStatus = SiteStatus(siteStatus: siteStatus)
        site.statuses.append(siteStatus)

        try await modelActor.insert(siteStatus)
        try await modelActor.save()
    }

}
