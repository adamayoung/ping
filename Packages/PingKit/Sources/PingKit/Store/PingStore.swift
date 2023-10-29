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
        state: PingState = PingState(),
        inMemoryStorage: Bool = false
    ) {
        self.init(
            state: state,
            dependencies: PingLiveDependencies(inMemoryStorage: inMemoryStorage)
        )
    }

    convenience init(
        state: PingState = PingState(),
        dependencies: PingDependencies
    ) {
        self.init(
            state: state,
            reduce: pingReducer,
            intercept: pingInterceptor,
            dependencies: dependencies
        )
    }

}
