//
//  SiteStatusCode+Icon.swift
//  Ping
//
//  Created by Adam Young on 02/11/2023.
//

import PingData
import SwiftUI

extension SiteStatus.Code {

    var iconName: String {
        switch self {
        case .success:
            return "wifi.circle.fill"

        case .failure:
            return "exclamationmark.triangle.fill"

        case .unknown:
            return "questionmark.circle.fill"
        }
    }

    var iconColor: Color {
        switch self {
        case .success:
            return .green

        case .failure:
            return .yellow

        case .unknown:
            return .gray
        }
    }

}
