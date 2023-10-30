//
//  StoreSiteStatusUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public protocol StoreSiteStatusUseCase {

    func execute(siteStatus: SiteStatus, for site: Site) async throws

}
