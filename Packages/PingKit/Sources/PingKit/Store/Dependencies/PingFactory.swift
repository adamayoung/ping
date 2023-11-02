//
//  PingFactory.swift
//  PingKit
//
//  Created by Adam Young on 01/11/2023.
//

import Foundation
import PingDomain

protocol PingFactory {

    func fetchSitesUseCase() -> any FetchSitesUseCase

    func addSiteUseCase() -> any AddSiteUseCase

    func removeSiteUseCase() -> any RemoveSiteUseCase

    func fetchLatestSiteStatusesUseCase() -> any FetchLatestSiteStatusesUseCase

    func checkSiteStatusUseCase() -> any CheckSiteStatusUseCase

    func checkAllSiteStatusesUseCase() -> any CheckAllSiteStatusesUseCase

    func storeSiteStatusUseCase() -> any StoreSiteStatusUseCase

}
