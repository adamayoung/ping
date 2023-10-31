//
//  SiteStatusCode.swift
//  PingData
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation

enum SiteStatusCode: Codable {
    case unknown
    case success
    case failure(String)
}
