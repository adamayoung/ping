//
//  AddSiteStatusUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public protocol AddSiteStatusUseCase {

    func execute(_ siteStatus: SiteStatus, for siteID: Site.ID) async throws

}
