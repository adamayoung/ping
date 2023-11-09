//
//  SiteStatusesState+Preview.swift
//  PingKit
//
//  Created by Adam Young on 28/10/2023.
//

import Foundation

extension SiteStatusesState {

    public static var preview: SiteStatusesState {
        var all = [Site.ID: [SiteStatus]]()
        all[Site.previews[0].id] = [
            SiteStatus(statusCode: .success, time: 5),
            SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some error")), time: 5),
            SiteStatus(statusCode: .success, time: 5)
        ]

        all[Site.previews[1].id] = [
            SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some error")), time: 5),
            SiteStatus(statusCode: .success, time: 5),
            SiteStatus(statusCode: .success, time: 5)
        ]

        all[Site.previews[2].id] = [
            SiteStatus(statusCode: .checking, time: 0),
            SiteStatus(statusCode: .success, time: 5),
            SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some error")), time: 5)
        ]

        all[Site.previews[3].id] = [
            SiteStatus(statusCode: .unknown, time: 5),
            SiteStatus(statusCode: .success, time: 5),
            SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some error")), time: 5),
            SiteStatus(statusCode: .success, time: 5)
        ]

        return SiteStatusesState(
            all: all
        )
    }

}
