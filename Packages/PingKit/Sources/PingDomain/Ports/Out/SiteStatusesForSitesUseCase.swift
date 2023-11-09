//
//  SiteStatusesForSitesUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 02/11/2023.
//

import Foundation

public protocol SiteStatusesForSitesUseCase {

    func execute(for siteIDs: [Site.ID]) async throws -> [Site.ID: [SiteStatus]]

}
