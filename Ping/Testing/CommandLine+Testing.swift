//
//  CommandLine+Testing.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

import Foundation

extension CommandLine {

    static var isUITesting: Bool {
        Self.arguments.contains("-uitest")
    }

}
