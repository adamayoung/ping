//
//  SiteStatusCode+Name.swift
//  Ping
//
//  Created by Adam Young on 13/11/2023.
//

import PingData
import SwiftUI

extension SiteStatus.Code {

    var localizedName: LocalizedStringKey {
        switch self {
        case .success:
            "SITE_STATUS_SUCCESS"

        case .failure:
            "SITE_STATUS_FAILURE"

        case .unknown:
            "SITE_STATUS_UNKNOWN"
        }
    }

}
