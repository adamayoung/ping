//
//  PingStore.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public typealias PingStore = Store<PingState, PingAction, PingDependencies>

extension PingStore {

    public convenience init(
        state: PingState = PingState()
    ) {
        self.init(
            state: state,
            dependencies: PingLiveDependencies()
        )
    }

    convenience init(
        state: PingState = PingState(),
        dependencies: PingDependencies = PingLiveDependencies()
    ) {
        self.init(
            state: state,
            reduce: pingReducer,
            intercept: pingInterceptor,
            dependencies: dependencies
        )
    }

}

extension PingStore {

    public static var preview: PingStore {
        .init(
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

}
