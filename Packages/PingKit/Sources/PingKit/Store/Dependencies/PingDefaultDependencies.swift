//
//  PingDefaultDependencies.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingData
import PingDomain

final class PingDefaultDependencies: PingDependencies {

    let sites: any SitesDependencies
    let siteStauses: any SiteStatusesDependencies

    convenience init(factory: some PingFactory) {
        self.init(
            sites: SitesDefaultDependencies(factory: factory),
            siteStauses: SiteStatusesDefaultDependencies(factory: factory)
        )
    }

    init(sites: some SitesDependencies, siteStauses: some SiteStatusesDependencies) {
        self.sites = sites
        self.siteStauses = siteStauses
    }

}
