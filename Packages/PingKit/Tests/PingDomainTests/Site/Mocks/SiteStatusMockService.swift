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

    var checkSiteResult: SiteStatus?
    private(set) var lastCheckSite: Site?

    func check(site: Site) async -> SiteStatus {
        guard let checkSiteResult else {
            precondition(false, "checkSiteResult not set")
        }

        lastCheckSite = site
        return checkSiteResult
    }

}

extension SiteStatusMockService {

    struct SiteStatusMockServiceError: Error { }

}
