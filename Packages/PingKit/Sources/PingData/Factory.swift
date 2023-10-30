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

    static var siteStatusModel: BackgroundModelActor<SiteStatus> = {
        BackgroundModelActor<SiteStatus>(container: modelContainer)
    }()

}

extension Factory {

    static var modelContainer: ModelContainer = {
        do {
            return try ModelContainer.ping(inMemory: PingDataConfiguration.inMemoryStorage)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

}
