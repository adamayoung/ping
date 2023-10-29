//
//  Factory.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

final class Factory {

    static var siteModel: BackgroundModelActor<Site> = {
        BackgroundModelActor<Site>(container: modelContainer)
    }()

}

extension Factory {

    static var modelContainer: ModelContainer = {
        let schema = Schema([
            Site.self
        ])

        if PingDataConfiguration.inMemoryStorage {
            print("Using IN MEMORY storage")
        }

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: PingDataConfiguration.inMemoryStorage
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

}
