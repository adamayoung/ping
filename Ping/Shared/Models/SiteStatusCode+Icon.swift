//
//  SiteStatusCode+Icon.swift
//  Ping
//
//  Created by Adam Young on 02/11/2023.
//

import PingKit
import SwiftUI

extension SiteStatusCode {

    var iconName: String {
        switch self {
        case .success:
            return "wifi.circle.fill"

        case .failure:
            return "exclamationmark.triangle.fill"

        case .unknown:
            return "questionmark.circle.fill"

        default:
            return ""
        }
    }

    var iconColor: Color {
        switch self {
        case .success:
            return .green

        case .failure:
            return .yellow

        default:
            return .gray
        }
    }

    var localizedName: LocalizedStringKey {
        switch self {
        case .success:
            "SITE_STATUS_SUCCESS"

        case .failure:
            "SITE_STATUS_FAILURE"

        case .checking:
            "SITE_STATUS_CHECKING"

        case .unknown:
            "SITE_STATUS_UNKNOWN"
        }
    }

}
