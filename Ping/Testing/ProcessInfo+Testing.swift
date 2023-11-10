//
//  CommandLine+Testing.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

import Foundation

extension ProcessInfo {

    var isUITesting: Bool {
        arguments.contains("-uitest")
    }

}
