//
//  SitesState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct SitesState: Equatable {

    public internal(set) var all: [Site]

    public init(
        all: [Site] = []
    ) {
        self.all = all
    }

}
