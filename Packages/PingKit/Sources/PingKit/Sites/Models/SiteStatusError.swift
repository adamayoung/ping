//
//  SiteStatusError.swift
//  PingKit
//
//  Created by Adam Young on 30/10/2023.
//

import Foundation

public struct SiteStatusError: LocalizedError {

    public let errorDescription: String?

    public init(errorDescription: String? = nil) {
        self.errorDescription = errorDescription
    }

}
