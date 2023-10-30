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

    private let siteStatusModel: BackgroundModelActor<SiteStatus>
    private let siteModel: BackgroundModelActor<Site>

    public init() {
        self.init(
            siteStatusModel: Factory.siteStatusModel,
            siteModel: Factory.siteModel
        )
    }

    init(
        siteStatusModel: BackgroundModelActor<SiteStatus>,
        siteModel: BackgroundModelActor<Site>
    ) {
        self.siteStatusModel = siteStatusModel
        self.siteModel = siteModel
    }

    public func statuses(for siteID: PingDomain.Site.ID) async throws -> [PingDomain.SiteStatus] {
        let fetchDescriptor = FetchDescriptor<SiteStatus>(sortBy: [SortDescriptor(\.timestamp)])
        let siteStatusModels = try await siteStatusModel.fetch(descriptor: fetchDescriptor)

        let siteStatuses = siteStatusModels.map(PingDomain.SiteStatus.init)

        return siteStatuses
    }

    public func save(siteStatus: PingDomain.SiteStatus, for siteID: PingDomain.Site.ID) async throws {
        let predicate = #Predicate<Site> { site in
            site.id == siteID
        }

        guard let site = try await siteModel.fetch(predicate: predicate).first else {
            return
        }

        let siteStatus = SiteStatus(siteStatus: siteStatus, site: site)
        try await siteStatusModel.save(siteStatus)
    }

}
