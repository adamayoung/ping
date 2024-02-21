//
//  SiteStatusResult.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation

public struct SiteStatusResult {

    public let siteID: UUID
    public let siteStatusCode: SiteStatus.Code
    public let time: TimeInterval

}
