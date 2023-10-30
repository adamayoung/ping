//
//  Site+Mapper.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

extension Site {

    convenience init(site: PingDomain.Site) {
        self.init(
            id: site.id,
            name: site.name,
            url: site.url,
            statuses: nil
        )
    }

}

extension PingDomain.Site {

    init(site: Site) {
        self.init(
            id: site.id,
            name: site.name,
            url: site.url
        )
    }

}
