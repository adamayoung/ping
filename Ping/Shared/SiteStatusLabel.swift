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

    var body: some View {
        Label {
            labelTitle
        } icon: {
            Image(systemName: iconName)
                .foregroundStyle(iconColor)
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
        }
    }

    private var labelTitle: some View {
        #if os(macOS)
        Text(verbatim: site.name)
        #else
        VStack(alignment: .leading, spacing: 4) {
            Text(verbatim: site.name)

            detailView
                .font(.caption)
                .foregroundStyle(Color.secondary)
        }
        #endif
    }

    private var iconName: String {
        switch siteStatus.statusCode {
        case .success:
            return "wifi.circle.fill"

        case .failure:
            return "wifi.exclamationmark.circle.fill"

        default:
            return "questionmark.circle.fill"
        }
    }

    private var iconColor: Color {
        switch siteStatus.statusCode {
        case .success:
            return .green

        case .failure:
            return .red

        default:
            return .gray
        }
    }

    private var detailView: some View {
        Text(Image(systemName: "clock")) +
        Text(verbatim: " ") +
        Text(siteStatus.timestamp.formatted(date: .numeric, time: .shortened))
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 20) {
        SiteStatusLabel(
            site: Site.previews[0],
            siteStatus: SiteStatus(statusCode: .success)
        )

        SiteStatusLabel(
            site: Site.previews[1],
            siteStatus: SiteStatus(statusCode: .checking)
        )

        SiteStatusLabel(
            site: Site.previews[2],
            siteStatus: SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some failure")))
        )

        SiteStatusLabel(
            site: Site.previews[3],
            siteStatus: SiteStatus(statusCode: .unknown)
        )
    }
    .padding()
}
