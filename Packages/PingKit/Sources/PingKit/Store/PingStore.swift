//
//  PingStore.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public typealias PingStore = Store<PingState, PingAction, PingDependencies>

extension PingStore {

    public convenience init() {
        self.init(
            state: PingState(),
            dependencies: PingDefaultDependencies(
                factory: PingDefaultFactory(
                    inMemoryStorage: false,
                    urlSession: .shared
                )
            )
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
