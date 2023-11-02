//
//  AddSiteFormModel.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

import Foundation
import Observation
import PingKit

@Observable
final class AddSiteFormModel {

    var name = ""
    var url = ""

    var isValid: Bool {
        Self.isValid(name: name) && Self.isValid(urlString: url)
    }

    var site: Site? {
        guard isValid else {
            return nil
        }

        guard let url = URL(string: url) else {
            return nil
        }

        return Site(name: name, url: url)
    }

    init() { }

}

extension AddSiteFormModel {

    private static func isValid(name: String) -> Bool {
        if name.isEmpty {
            return false
        }

        return true
    }

    private static func isValid(urlString: String) -> Bool {
        guard
            let url = URL(string: urlString),
            let scheme = url.scheme,
            let host = url.host()
        else {
            return false
        }

        guard scheme == "https" else {
            return false
        }

        guard host.contains(".") && !host.hasSuffix(".") else {
            return false
        }

        return true
    }

}
