//
//  SiteStatusHeaderView.swift
//  Ping
//
//  Created by Adam Young on 02/11/2023.
//

import SwiftData
import SwiftUI

struct SiteStatusHeaderView: View {

    var site: Site
    var siteStatus: SiteStatus?
    var isCheckingStatus: Bool
    var refreshSiteStatus: () -> Void

    private var statusCode: SiteStatus.Code {
        siteStatus?.statusCode ?? .default
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: statusCode.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white, statusCode.iconColor)
                .frame(height: 100)
                .padding()
                .shadow(color: .secondary, radius: 5, x: 2, y: 2)
                .opacity(isCheckingStatus ? 0 : 1)
                .overlay {
                    if isCheckingStatus {
                        ProgressView()
                            .controlSize(.extraLarge)
                    }
                }

            Text(siteStatusText)
                .font(.system(size: 25))
                .multilineTextAlignment(.center)

            Text("\(Image(systemName: "clock")) \(siteStatus?.formattedTimestamp ?? "")")
                .foregroundStyle(.secondary)
                .opacity((isCheckingStatus || statusCode == .unknown) ? 0 : 1)

            Button("REFRESH") {
                refreshSiteStatus()
            }
            .padding(.top)
            .opacity(isCheckingStatus ? 0 : 1)
        }
        .animation(.spring, value: statusCode)
    }

    private var siteStatusText: LocalizedStringKey {
        if isCheckingStatus {
            return "CHECKING_\(site.name)"
        }

        switch statusCode {
        case .success:
            return "\(site.name)_IS_UP_AND_RUNNING"

        case .failure:
            return "TROUBLE_LOADING_\(site.name)"

        case .unknown:
            return "STATUS_OF_\(site.name)_IS_UNKNOWN"
        }
    }

}

#Preview("Success") {
    let modelContainer = ModelContainer.preview
    let site = Site.gitHubPreview

    return VStack {
        SiteStatusHeaderView(
            site: site,
            siteStatus: SiteStatus(statusCode: .success, time: 5),
            isCheckingStatus: false,
            refreshSiteStatus: { }
        )
        Spacer()
    }
    .modelContainer(modelContainer)
}

#Preview("Failure") {
    let modelContainer = ModelContainer.preview
    let site = Site.gitHubPreview

    return VStack {
        SiteStatusHeaderView(
            site: site,
            siteStatus: SiteStatus(
                statusCode: .failure("Some error"),
                time: 5
            ),
            isCheckingStatus: false,
            refreshSiteStatus: { }
        )
        Spacer()
    }
    .modelContainer(modelContainer)
}

#Preview("Checking") {
    let modelContainer = PingFactory.shared.modelContainer
    let site = Site.gitHubPreview

    return VStack {
        SiteStatusHeaderView(
            site: site,
            siteStatus: SiteStatus(statusCode: .success, time: 5),
            isCheckingStatus: true,
            refreshSiteStatus: { }
        )
        Spacer()
    }
    .modelContainer(modelContainer)
}

#Preview("Unknown") {
    let modelContainer = PingFactory.shared.modelContainer
    let site = Site.gitHubPreview

    return VStack {
        SiteStatusHeaderView(
            site: site,
            siteStatus: SiteStatus(statusCode: .unknown, time: 5),
            isCheckingStatus: false,
            refreshSiteStatus: { }
        )
        Spacer()
    }
    .modelContainer(modelContainer)
}
