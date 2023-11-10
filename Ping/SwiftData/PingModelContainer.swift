//
//  PingModelContainer.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Foundation
import SwiftData

extension ModelContainer {

    @MainActor static var ping: ModelContainer = {
        let modelConfiguration = ModelConfiguration(schema: Schema.ping)

        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer(for: Schema.ping, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

        return modelContainer
    }()

    @MainActor static var preview: ModelContainer = {
        let modelConfiguration = ModelConfiguration(schema: Schema.ping, isStoredInMemoryOnly: true,
                                                    cloudKitDatabase: .none)

        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer(for: Schema.ping, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

        reloadSampleData(modelContext: modelContainer.mainContext)

        return modelContainer
    }()

}

extension ModelContainer {

    private static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Site.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private static func insertSampleData(modelContext: ModelContext) {
        Site.previews.forEach {
            modelContext.insert($0)
        }

        SiteGroup.previews.forEach {
            modelContext.insert($0)
        }

        do {
            try modelContext.save()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
