//
//  SiteStatusService.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol SiteStatusService {

    func check(siteID: UUID) async throws -> SiteStatus

}
