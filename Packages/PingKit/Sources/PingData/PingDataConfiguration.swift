//
//  PingDataConfiguration.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation

public final class PingDataConfiguration {

    static private(set) var inMemoryStorage: Bool = false

    private init() { }

    public static func setInMemoryStorage(_ inMemory: Bool) {
        Self.inMemoryStorage = inMemory
    }

}
