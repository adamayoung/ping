//
//  SiteStatusRequestTask+.swift
//  Ping
//
//  Created by Adam Young on 13/11/2023.
//

import Foundation

extension SiteStatusRequestTask {

    init?(siteRequest: SiteStatusRequest?) {
        guard let siteRequest, let siteID = siteRequest.site?.id else {
            return nil
        }

        self.init(
            siteID: siteID,
            url: siteRequest.url,
            method: "GET",
            timeout: siteRequest.timeout
        )
    }

}
