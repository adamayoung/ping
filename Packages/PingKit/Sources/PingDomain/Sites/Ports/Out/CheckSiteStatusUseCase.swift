//
//  CheckSiteStatusUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol CheckSiteStatusUseCase {

    func execute(site: Site) async throws -> SiteStatus

}
