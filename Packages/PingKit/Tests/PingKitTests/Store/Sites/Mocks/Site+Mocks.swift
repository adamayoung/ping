//
//  Site+Mocks.swift
//  PingKitTests
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingKit

extension Site {

    static var google: Site {
        Site(
            id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
            name: "Google",
            url: URL(string: "https://www.google.com")!
        )
    }

    static var gitHub: Site {
        Site(
            id: UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!,
            name: "GitHub",
            url: URL(string: "https://github.com")!
        )
    }

    static var twitter: Site {
        Site(
            id: UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!,
            name: "Twitter",
            url: URL(string: "https://twitter.com")!
        )
    }

    static var microsoft: Site {
        Site(
            id: UUID(uuidString: "D86808FA-E0BE-467D-BB38-7092FDD95A5C")!,
            name: "Microsoft",
            url: URL(string: "https://microsoft.com")!
        )
    }

}
