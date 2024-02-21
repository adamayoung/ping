//
//  AddSiteGroupFormModel.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation
import Observation
import PingData
import SwiftData

@Observable
final class AddSiteGroupFormModel {

    var name = ""

    var isValid: Bool {
        Self.isValid(name: name)
    }

    var siteGroup: SiteGroup? {
        guard isValid else {
            return nil
        }

        let siteGroup = SiteGroup(name: name)

        return siteGroup
    }

    init() { }

}

extension AddSiteGroupFormModel {

    private static func isValid(name: String) -> Bool {
        if name.isEmpty {
            return false
        }

        return true
    }

}
