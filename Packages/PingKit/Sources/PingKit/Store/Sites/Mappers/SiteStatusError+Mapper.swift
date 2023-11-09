//
//  SiteStatusError+Mapper.swift
//  PingKit
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

extension SiteStatusError {

    init(error: PingDomain.SiteStatusError) {
        self.init(errorDescription: error.errorDescription)
    }

}

extension PingDomain.SiteStatusError {

    init(error: SiteStatusError) {
        self.init(errorDescription: error.errorDescription)
    }

}
