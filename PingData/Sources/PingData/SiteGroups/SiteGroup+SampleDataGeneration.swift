//
//  File.swift
//  
//
//  Created by Adam Young on 16/02/2024.
//

import Foundation

extension SiteGroup {

    static func generate() -> [SiteGroup] {
        [
            .development,
            .techCompanies
        ]
    }

    static let development = SiteGroup(
        id: .developmentSiteGroupID,
        name: "Development",
        sites: [Site.gitHub]
    )

    static let techCompanies = SiteGroup(
        id: .techCompaniesSiteGroupID,
        name: "Tech Companies",
        sites: [Site.google, Site.microsoft]
    )

}

extension UUID {

    static var developmentSiteGroupID: UUID {
        UUID(uuidString: "73F416B6-4CFD-41AB-AD1A-7491E05BFEC8")!
    }

    static var techCompaniesSiteGroupID: UUID {
        UUID(uuidString: "5F28FB07-E46D-4DE2-935F-FD59FEE0B5D5")!
    }

}
