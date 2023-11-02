//
//  SitesState+Preview.swift
//  PingKit
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

extension SitesState {

    public static var preview: SitesState {
        SitesState(
            all: Site.previews,
            siteStatuses: [
                Site.previews[0].id: SiteStatus(statusCode: .success),
                Site.previews[1].id: SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some error"))),
                Site.previews[2].id: SiteStatus(statusCode: .checking),
                Site.previews[3].id: SiteStatus(statusCode: .unknown)
            ]
        )
    }

}
