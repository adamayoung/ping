//
//  Site+Preview.swift
//  PingKit
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

extension Site {

    public static var preview: Site {
        Site(
            id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
            name: "Google",
            url: URL(string: "https://www.google.com")!
        )
    }

    public static var previews: [Site] {
        [
            Site(
                id: UUID(uuidString: "C26FF5CF-5337-4725-B9E5-2B4491CFF855")!,
                name: "Google",
                url: URL(string: "https://www.google.com")!
            ),
            Site(
                id: UUID(uuidString: "FBFCD00D-B8FF-4421-AE52-AA84EF212E52")!,
                name: "GitHub",
                url: URL(string: "https://github.com")!
            ),
            Site(
                id: UUID(uuidString: "D7874391-0048-40B5-9569-C7D8DBBA329A")!,
                name: "Twitter",
                url: URL(string: "https://twitter.com")!
            ),
            Site(
                id: UUID(uuidString: "DC9434E8-B761-4193-9E6C-C1D6360D24D2")!,
                name: "Microsoft",
                url: URL(string: "https://microsoft.com")!
            )
        ]
    }

}
