//
//  SiteStatus+Preview.swift
//  PingKit
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation

extension SiteStatus {

    public static func preview(_ statusCode: SiteStatusCode) -> SiteStatus {
        SiteStatus(statusCode: statusCode)
    }

}
