//
//  CheckAllSiteStatusesUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public protocol CheckAllSiteStatusesUseCase {

    func execute() async throws -> [Site.ID: SiteStatus]

}
