//
//  SiteStatusCode.swift
//  PingKit
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public enum SiteStatusCode: Equatable, Hashable {

    case success
    case failure(SiteStatusError)
    case checking
    case unknown

}
