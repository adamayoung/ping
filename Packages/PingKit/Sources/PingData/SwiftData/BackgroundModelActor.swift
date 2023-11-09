//
//  BackgroundModelActor.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

actor BackgroundModelActor {

    nonisolated let modelContainer: ModelContainer
    nonisolated let modelExecutor: any ModelExecutor

    private var context: ModelContext { modelExecutor.modelContext }

    init(container: ModelContainer) {
        self.modelContainer = container
        let context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }

    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        try context.fetch(descriptor)
    }

    func insert(_ model: some PersistentModel) throws {
        context.insert(model)
    }

    func `delete`(_ model: some PersistentModel) throws {
        context.delete(model)
    }

    func `delete`<T: PersistentModel>(_ predicate: Predicate<T>, includeSubclasses: Bool = true) throws {
        try context.delete(model: T.self, where: predicate, includeSubclasses: includeSubclasses)
    }

    func save() throws {
        try context.save()
    }

}
