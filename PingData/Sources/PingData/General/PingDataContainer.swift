//
//  PingDataContainer.swift
//  PingData
//
//  Created by Adam Young on 16/02/2024.
//

import SwiftData
import SwiftUI

struct PingDataContainerViewModifier: ViewModifier {

    let container: ModelContainer

    init(inMemory: Bool) {
        do {
            container = try ModelContainer(
                for: Schema.ping,
                configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)]
            )
        } catch let error {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    func body(content: Content) -> some View {
        content
            .modelContainer(container)
    }

}

public extension View {

    func pingDataContainer(inMemory: Bool = false) -> some View {
        modifier(PingDataContainerViewModifier(inMemory: inMemory))
    }

}
