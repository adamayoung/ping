//
//  SiteStatusLabel.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

import SwiftData
import SwiftUI

struct SiteStatusLabel: View {

    var site: Site
    var siteStatus: SiteStatus?
    var isCheckingStatus: Bool

    private var statusCode: SiteStatus.Code {
        siteStatus?.statusCode ?? .default
    }

    private var formattedTimestamp: String {
        siteStatus?.timestamp.formatted(date: .numeric, time: .shortened) ?? ""
    }

    var body: some View {
        Label {
            labelTitle
        } icon: {
            Image(systemName: statusCode.iconName)
                .foregroundStyle(statusCode.iconColor)
                .opacity(isCheckingStatus ? 0 : 1)
                .overlay {
                    if isCheckingStatus {
                        ProgressView()
                            #if os(macOS)
                            .controlSize(.mini)
                            #else
                            .controlSize(.regular)
                            #endif
                    }
                }
                .animation(.easeIn, value: isCheckingStatus)
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

            Group {
                if statusCode == .unknown {
                    Text(verbatim: "-")
                } else {
                    Text("\(Image(systemName: "clock")) \(formattedTimestamp)")
                }
            }
            .font(.caption)
            .foregroundStyle(Color.secondary)

        }
        #endif
    }
}

#Preview {
    let modelContainer = ModelContainer.preview
    let googleSite = Site.googlePreview
    let twitterSite = Site.twitterPreview
    let gitHubSite = Site.gitHubPreview
    let microsoft = Site.microsoftPreview

    return VStack(alignment: .leading, spacing: 20) {
        SiteStatusLabel(
            site: googleSite,
            siteStatus: SiteStatus(statusCode: .success, time: 5),
            isCheckingStatus: false
        )

        SiteStatusLabel(
            site: twitterSite,
            siteStatus: SiteStatus(statusCode: .unknown, time: 5),
            isCheckingStatus: false
        )

        SiteStatusLabel(
            site: gitHubSite,
            siteStatus: SiteStatus(statusCode: .failure("Error"), time: 5),
            isCheckingStatus: false
        )

        SiteStatusLabel(
            site: microsoft,
            siteStatus: SiteStatus(statusCode: .unknown, time: 5),
            isCheckingStatus: true
        )
    }
    .padding()
    .modelContainer(modelContainer)
}
