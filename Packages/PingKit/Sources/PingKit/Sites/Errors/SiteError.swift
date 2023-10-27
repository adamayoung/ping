//
//  File.swift
//
//
//  Created by Adam Young on 27/10/2023.
//

import Foundation

enum SiteError: LocalizedError {

    case fetchError(Error)

    var errorDescription: String? {
        switch self {
        case .fetchError:
            return "Could not fetch sites"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .fetchError:
            return nil
        }
    }
}
