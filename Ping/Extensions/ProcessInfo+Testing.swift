//
//  CommandLine+Testing.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

import Foundation

extension ProcessInfo {

    static var isSwiftUIPreview: Bool {
        processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    static var isUITest: Bool {
        processInfo.arguments.contains("-uitest")
    }

}
