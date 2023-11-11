//
//  SiteGroup+Preview.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation

extension SiteGroup {

    static let previews: [SiteGroup] = [
        .developmentPreview,
        .techCompaniesPreview
    ]

    static let developmentPreview = SiteGroup(
        id: UUID.developmentSiteGroupIDPreview,
        name: "Development",
        sites: [.gitHubPreview]
    )

    static let techCompaniesPreview = SiteGroup(
        id: UUID.techCompaniesSiteGroupIDPreview,
        name: "Tech Companies",
        sites: [.googlePreview, .microsoftPreview]
    )

}

extension UUID {

    static var developmentSiteGroupIDPreview: UUID {
        UUID(uuidString: "73F416B6-4CFD-41AB-AD1A-7491E05BFEC8")!
    }

    static var techCompaniesSiteGroupIDPreview: UUID {
        UUID(uuidString: "5F28FB07-E46D-4DE2-935F-FD59FEE0B5D5")!
    }

}
