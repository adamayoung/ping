//
//  PingStore+Preview.swift
//  PingKit
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

extension PingStore {

    public static func preview(state: PingState = .preview) -> PingStore {
        PingStore(
            state: state,
            reduce: { state, _ in
                state
            },
            intercept: { _, _, _ in
                nil
            },
            dependencies: PingDefaultDependencies(
                factory: PingDefaultFactory(
                    inMemoryStorage: true,
                    urlSession: .shared
                )
            )
        )
    }

}
