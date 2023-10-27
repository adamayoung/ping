//
//  PingAction.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public enum PingAction {

    case fetchSites
    case fetchSitesError(Error)
    case setSites([Site])

    case saveSite(Site)
    case addSite(Site)

}
