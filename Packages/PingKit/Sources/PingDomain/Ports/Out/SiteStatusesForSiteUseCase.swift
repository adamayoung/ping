//
//  SiteStatusesForSiteUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 02/11/2023.
//

import Foundation

public protocol SiteStatusesForSiteUseCase {

    func execute(for siteID: Site.ID) async throws -> [SiteStatus]

}
