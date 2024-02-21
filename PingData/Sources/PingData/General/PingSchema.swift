//
//  PingSchema.swift
//  PingData
//
//  Created by Adam Young on 16/02/2024.
//

import Foundation
import SwiftData

extension Schema {

    static var ping: Schema {
        Schema([
            SiteGroup.self,
            Site.self,
            SiteStatusRequest.self,
            SiteStatus.self
        ])
    }

}
