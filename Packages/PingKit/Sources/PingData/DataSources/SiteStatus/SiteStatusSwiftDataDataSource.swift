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

    public func fetchAll(for siteIDs: [UUID]) async throws -> [UUID: [PingDomain.SiteStatus]] {
        let sortDescriptors: [SortDescriptor<SiteStatus>] = [SortDescriptor(\.timestamp)]
        let fetchDescriptor = FetchDescriptor<SiteStatus>(sortBy: sortDescriptors)
        let siteStatusModels = try await modelActor.fetch(fetchDescriptor)
        var allSiteStatuses = [UUID: [PingDomain.SiteStatus]]()
        for siteStatusModel in siteStatusModels {
            guard let siteID = siteStatusModel.site?.id else {
                continue
            }

            var siteStatuses = allSiteStatuses[siteID, default: []]
            let siteStatus = PingDomain.SiteStatus(siteStatus: siteStatusModel)
            siteStatuses.append(siteStatus)
            allSiteStatuses[siteID] = siteStatuses
        }

        return allSiteStatuses
    }

    public func fetchAll(for siteID: UUID) async throws -> [PingDomain.SiteStatus] {
        let predicate = #Predicate<SiteStatus> { $0.site?.id == siteID }
        let sortDescriptors: [SortDescriptor<SiteStatus>] = [SortDescriptor(\.timestamp)]
        let fetchDescriptor = FetchDescriptor<SiteStatus>(predicate: predicate, sortBy: sortDescriptors)
        let siteStatusModels = try await modelActor.fetch(fetchDescriptor)

        let siteStatuses = siteStatusModels.map(PingDomain.SiteStatus.init)

        return siteStatuses
    }

    public func save(_ siteStatus: PingDomain.SiteStatus, for siteID: UUID) async throws {
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
