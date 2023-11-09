//
//  SiteStatusLabel.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

import PingKit
import SwiftUI

struct SiteStatusLabel: View {

    var site: Site
    var siteStatus: SiteStatus

    private var statusCode: SiteStatusCode {
        siteStatus.statusCode
    }

    private var formattedTimestamp: String {
        siteStatus.timestamp.formatted(date: .numeric, time: .shortened)
    }

    var body: some View {
        Label {
            labelTitle
        } icon: {
            Image(systemName: statusCode.iconName)
                .foregroundStyle(statusCode.iconColor)
                .opacity(siteStatus.statusCode == .checking ? 0 : 1)
                .overlay {
                    if siteStatus.statusCode == .checking {
                        ProgressView()
                            #if os(macOS)
                            .controlSize(.mini)
                            #else
                            .controlSize(.regular)
                            #endif
                    }
                }
                .animation(.easeIn, value: siteStatus.statusCode)
                .help(statusCode.localizedName)
                .accessibilityValue(Text(statusCode.localizedName))
        }
    }

    private var labelTitle: some View {
        #if os(macOS)
        Text(verbatim: site.name)
        #else
        VStack(alignment: .leading, spacing: 4) {
            Text(verbatim: site.name)

            Text("\(Image(systemName: "clock")) \(formattedTimestamp)")
                .font(.caption)
                .foregroundStyle(Color.secondary)
        }
        #endif
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 20) {
        SiteStatusLabel(
            site: Site.previews[0],
            siteStatus: SiteStatus(statusCode: .success, time: 5)
        )

        SiteStatusLabel(
            site: Site.previews[1],
            siteStatus: SiteStatus(statusCode: .checking, time: 5)
        )

        SiteStatusLabel(
            site: Site.previews[2],
            siteStatus: SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some failure")), time: 5)
        )

        SiteStatusLabel(
            site: Site.previews[3],
            siteStatus: SiteStatus(statusCode: .unknown, time: 5)
        )
    }
    .padding()
}
