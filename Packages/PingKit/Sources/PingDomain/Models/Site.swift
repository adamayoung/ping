//
//  Site.swift
//  PingDomain
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

public struct Site: Identifiable, Equatable, Hashable {

    public let id: UUID
    public let name: String
    public let request: SiteStatusRequest
    public let isActive: Bool

    public init(
        id: UUID = UUID(),
        name: String,
        request: SiteStatusRequest,
        isActive: Bool = true
    ) {
        self.id = id
        self.name = name
        self.request = request
        self.isActive = isActive
    }

}
