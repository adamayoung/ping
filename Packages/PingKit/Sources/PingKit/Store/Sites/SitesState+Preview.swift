//
//  SitesState+Preview.swift
//  PingKit
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

extension SitesState {

    public static var preview: SitesState {
        SitesState(
            all: Site.previews
        )
    }

}
