//
//  PingSchema.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Foundation
import SwiftData

extension Schema {

    static var ping: Schema {
        Schema([
            Site.self,
            SiteStatusRequest.self,
            SiteStatus.self
        ])
    }

}
