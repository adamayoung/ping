//
//  PingStore+Preview.swift
//  PingKit
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

extension PingStore {

    public static var preview: PingStore {
        PingStore(
            state: .preview,
            reduce: { state, _ in
                state
            },
            intercept: { _, _, _ in
                nil
            },
            dependencies: PingLiveDependencies()
        )
    }

    public static var test: PingStore {
        PingStore(state: .preview, inMemoryStorage: true)
    }

}
