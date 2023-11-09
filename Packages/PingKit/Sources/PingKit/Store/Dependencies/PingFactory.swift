//
//  PingFactory.swift
//  PingKit
//
//  Created by Adam Young on 01/11/2023.
//

import Foundation
import PingDomain

protocol PingFactory {

    // MARK: - Sites

    func allSitesUseCase() -> any AllSitesUseCase

    func addSiteUseCase() -> any AddSiteUseCase

    func removeSiteUseCase() -> any RemoveSiteUseCase

    // MARK: - Site Statuses

    func siteStatusesForSitesUseCase() -> any SiteStatusesForSitesUseCase

    func siteStatusesForSiteUseCase() -> any SiteStatusesForSiteUseCase

    func checkSiteStatusForSiteUseCase() -> any CheckSiteStatusForSiteUseCase

    func checkSiteStatusForSitesUseCase() -> any CheckSiteStatusForSitesUseCase

    func addSiteStatusUseCase() -> any AddSiteStatusUseCase

}
