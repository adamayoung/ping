//
//  CheckSiteStatusForSitesUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol CheckSiteStatusForSitesUseCase {

    func execute(for sites: [Site]) async throws -> [Site.ID: SiteStatus]

}
