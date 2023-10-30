//
//  CheckSiteUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol CheckSiteUseCase {

    func execute(siteID: UUID) async throws -> SiteStatus

}
