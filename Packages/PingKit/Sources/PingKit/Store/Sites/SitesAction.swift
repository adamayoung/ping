//
//  SitesAction.swift
//  PingKit
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

public enum SitesAction: Sendable {

    case load
    case set([Site])
    case store(Site)
    case remove(Site)

}
