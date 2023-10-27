//
//  Store.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import Observation

@dynamicMemberLookup
@Observable
public final class Store<State, Action, Dependencies> {

    public typealias Reduce = (State, Action) -> State
    public typealias Intercept = (State, Action, Dependencies) async -> Action?

    private var state: State
    @ObservationIgnored private let reduce: Reduce
    @ObservationIgnored private let intercept: Intercept
    @ObservationIgnored private let dependencies: Dependencies

    public init(
        state: State,
        reduce: @escaping Reduce,
        intercept: @escaping Intercept,
        dependencies: Dependencies
    ) {
        self.state = state
        self.reduce = reduce
        self.intercept = intercept
        self.dependencies = dependencies
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        state[keyPath: keyPath]
    }

    @MainActor
    public func send(_ action: Action) async {
        state = reduce(state, action)

        if let nextAction = await intercept(state, action, dependencies) {
            await send(nextAction)
        }
    }

}
