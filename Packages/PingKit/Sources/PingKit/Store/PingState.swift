//
//  PingState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct PingState {

    public internal(set) var sites: SitesState

    public init(
        sites: SitesState = SitesState()
    ) {
        self.sites = sites
    }

}
