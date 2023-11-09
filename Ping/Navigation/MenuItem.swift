//
//  Panel.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation
import PingKit

enum MenuItem: Hashable {

    case summary
    case site(Site)

}

extension MenuItem {

    static var `default`: MenuItem? {
        #if os(macOS)
        return .summary
        #else
        return nil
        #endif
    }

}
