//
//  SiteStatusCode+Mapper.swift
//  PingData
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation
import PingDomain

extension SiteStatusCode {

    init(siteStatusCode: PingDomain.SiteStatusCode) {
        switch siteStatusCode {
        case .unknown:
            self = .unknown

        case .success:
            self = .success

        case .failure(let error):
            self = .failure(error.localizedDescription)
        }
    }

}

extension PingDomain.SiteStatusCode {

    init(siteStatusCode: SiteStatusCode) {
        switch siteStatusCode {
        case .unknown:
            self = .unknown

        case .success:
            self = .success

        case .failure(let message):
            let error = SiteStatusError(errorDescription: message)
            self = .failure(error)
        }
    }

}