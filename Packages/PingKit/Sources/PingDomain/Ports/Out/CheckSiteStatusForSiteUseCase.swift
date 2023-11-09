//
//  CheckSiteStatusForSiteUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol CheckSiteStatusForSiteUseCase {

    func execute(for site: Site) async throws -> SiteStatus

}
