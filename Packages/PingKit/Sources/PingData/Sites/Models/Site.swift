//
//  Site.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

@Model
final class Site {

    var id: UUID
    var name: String
    var url: URL

    init(
        id: UUID,
        name: String,
        url: URL
    ) {
        self.id = id
        self.name = name
        self.url = url
    }

}
