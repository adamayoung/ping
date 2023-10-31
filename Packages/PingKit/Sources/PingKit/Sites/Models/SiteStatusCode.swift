//
//  SiteStatusCode.swift
//  PingKit
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public enum SiteStatusCode: Equatable {

    case unknown
    case checking
    case success
    case failure(SiteStatusError)

    public static func == (lhs: SiteStatusCode, rhs: SiteStatusCode) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true

        case (.failure, .failure):
            return true

        case (.unknown, .unknown):
            return true

        default:
            return false
        }
    }

}
