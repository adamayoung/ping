//
//  RemoveSiteUseCase.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public protocol RemoveSiteUseCase {

    func execute(_ siteID: Site.ID) async throws

}
