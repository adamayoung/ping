//
//  SiteView.swift
//  Ping
//
//  Created by Adam Young on 27/10/2023.
//

import PingKit
import SwiftUI

struct SiteView: View {

    var site: Site

    var body: some View {
        Text(verbatim: site.url.absoluteString)
            .navigationTitle(site.name)
    }

}

#Preview {
    SiteView(site: .preview)
}
