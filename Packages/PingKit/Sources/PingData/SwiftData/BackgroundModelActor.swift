//
//  BackgroundModelActor.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

actor BackgroundModelActor<T: PersistentModel>: ModelActor {

    nonisolated let modelContainer: ModelContainer
    nonisolated let modelExecutor: any ModelExecutor

    private var context: ModelContext { modelExecutor.modelContext }

    init(container: ModelContainer) {
        self.modelContainer = container
        let context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }

    func fetch(descriptor: FetchDescriptor<T>) throws -> [T] {
        let list: [T] = try context.fetch(descriptor)
        return list
    }

    func fetch(predicate: Predicate<T>? = nil) throws -> [T] {
        let fetchDescriptor = FetchDescriptor<T>(predicate: predicate)
        let list: [T] = try context.fetch(fetchDescriptor)
        return list
    }

    func save(_ model: T) throws {
        try save([model])
    }

    func save(_ models: [T]) throws {
        models.forEach {
            context.insert($0)
        }

        try context.save()
    }

    func `delete`(predicate: Predicate<T>? = nil) throws {
        try context.delete(model: T.self, where: predicate)
    }

}
