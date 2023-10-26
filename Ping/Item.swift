//
//  Item.swift
//  Ping
//
//  Created by Adam Young on 26/10/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
