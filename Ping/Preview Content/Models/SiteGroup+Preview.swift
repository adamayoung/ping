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
        name: "Development",
        sites: [.gitHubPreview]
    )

    static let techCompaniesPreview = SiteGroup(
        name: "Tech Companies",
        sites: [.googlePreview, .microsoftPreview]
    )

}
