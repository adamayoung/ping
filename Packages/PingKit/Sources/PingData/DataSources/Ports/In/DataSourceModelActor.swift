//
//  Model.swift
//  PingData
//
//  Created by Adam Young on 03/11/2023.
//

import Foundation
import SwiftData

protocol DataSourceModelActor: ModelActor {

    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T]

    func insert(_ model: some PersistentModel) throws

    func `delete`(_ model: some PersistentModel) throws

    func `delete`<T: PersistentModel>(_ predicate: Predicate<T>, includeSubclasses: Bool) throws

    func `delete`<T: PersistentModel>(_ predicate: Predicate<T>) throws

    func save() throws

}

extension DataSourceModelActor {

    func `delete`<T: PersistentModel>(_ predicate: Predicate<T>) throws {
        try self.delete(predicate, includeSubclasses: true)
    }

}
