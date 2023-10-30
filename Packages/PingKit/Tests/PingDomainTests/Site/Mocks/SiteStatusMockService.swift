//
//  SiteStatusMockService.swift
//  PingDomainTests
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

final class SiteStatusMockService: SiteStatusService {

    init() { }

    var checkSiteResult: Result<SiteStatus, Error> = .failure(SiteStatusMockServiceError())
    private(set) var lastCheckSite: Site?

    func check(site: Site) async throws -> SiteStatus {
        lastCheckSite = site
        return try checkSiteResult.get()
    }

}

extension SiteStatusMockService {

    struct SiteStatusMockServiceError: Error { }

}
