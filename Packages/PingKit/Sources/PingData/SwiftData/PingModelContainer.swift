//
//  ModelContainer.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

extension ModelContainer {

    static func ping(inMemory: Bool) throws -> ModelContainer {
        let schema = Schema([
            Site.self,
            SiteStatus.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: inMemory
        )

        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    }

}
