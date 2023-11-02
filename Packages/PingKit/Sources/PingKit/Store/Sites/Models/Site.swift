//
//  Site.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct Site: Identifiable, Equatable, Hashable {

    public let id: UUID
    public let name: String
    public let url: URL

    public init(
        id: UUID = UUID(),
        name: String,
        url: URL
    ) {
        self.id = id
        self.name = name
        self.url = url
    }

}
