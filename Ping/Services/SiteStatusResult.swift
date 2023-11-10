//
//  SiteStatusResult.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation

struct SiteStatusResult: Sendable {

    let siteID: UUID
    let siteStatusCode: SiteStatus.Code
    let time: TimeInterval

}
