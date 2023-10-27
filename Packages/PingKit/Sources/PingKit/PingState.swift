//
//  PingState.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public struct PingState {

    public internal(set) var sites: [Site]
    public internal(set) var sitesError: LocalizedError?

    public init(
        sites: [Site] = [],
        sitesError: LocalizedError? = nil
    ) {
        self.sites = sites
        self.sitesError = sitesError
    }

}

extension PingState {

    public static var preview: PingState {
        PingState(
            sites: Site.previews,
            sitesError: nil
        )
    }

}
