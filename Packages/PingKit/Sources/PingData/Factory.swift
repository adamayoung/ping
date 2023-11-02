//
//  Factory.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import SwiftData

final class Factory {

    static func modelActor(inMemory: Bool) -> BackgroundModelActor {
        if inMemory {
            return inMemoryModelActor
        }

        return diskModelActor
    }

}

extension Factory {

    private static var diskModelActor: BackgroundModelActor = {
        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer.ping(inMemory: false)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

        let modelActor = BackgroundModelActor(container: modelContainer)
        return modelActor
    }()

    private static var inMemoryModelActor: BackgroundModelActor = {
        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer.ping(inMemory: true)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

        let modelActor = BackgroundModelActor(container: modelContainer)
        return modelActor
    }()

}
