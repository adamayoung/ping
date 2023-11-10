//
//  AddSiteFormModel.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

import Foundation
import Observation
import SwiftData
import SwiftUI

@Observable
final class AddSiteFormModel {

    var name = ""
    var url = ""
    var siteGroup: SiteGroup?
    var timeout = 10000
    var method: AddSiteFormModel.Method = .get

    var isValid: Bool {
        Self.isValid(name: name) && Self.isValid(urlString: url) && Self.isValue(timeout: timeout)
    }

    var site: Site? {
        guard isValid else {
            return nil
        }

        guard let url = URL(string: url) else {
            return nil
        }

        let site = Site(name: name)
        let timeout = TimeInterval(self.timeout) / 1000
        let method: SiteStatusRequest.Method = {
            switch self.method {
            case .get:
                return .get
            }
        }()

        let siteRequest = SiteStatusRequest(url: url, method: method, timeout: timeout)
        site.request = siteRequest
        site.group = siteGroup

        return site
    }

    init() { }

}

extension AddSiteFormModel {

    enum Method: CaseIterable {

        case get

        var localizedName: LocalizedStringKey {
            switch self {
            case .get:
                return "GET"
            }
        }
    }

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

    private static func isValue(timeout: Int) -> Bool {
        guard timeout >= 1000 else {
            return false
        }

        return true
    }

}
