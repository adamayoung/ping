//
//  SiteStatusHeaderView.swift
//  Ping
//
//  Created by Adam Young on 02/11/2023.
//

import PingKit
import SwiftUI

struct SiteStatusHeaderView: View {

    var site: Site
    var siteStatus: SiteStatus
    var refreshSiteStatus: () -> Void

    private var isChecking: Bool {
        siteStatus.statusCode == .checking
    }

    private var formattedTimestamp: String {
        siteStatus.timestamp.formatted(date: .numeric, time: .shortened)
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: siteStatus.statusCode.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white, siteStatus.statusCode.iconColor)
                .frame(height: 100)
                .padding()
                .shadow(color: .secondary, radius: 5, x: 2, y: 2)
                .opacity(isChecking ? 0 : 1)
                .overlay {
                    if siteStatus.statusCode == .checking {
                        ProgressView()
                            .controlSize(.extraLarge)
                    }
                }

            Text(siteStatusText)
                .font(.system(size: 25))
                .multilineTextAlignment(.center)

            Text("\(Image(systemName: "clock")) \(formattedTimestamp)")
                .foregroundStyle(.secondary)
                .opacity(isChecking ? 0 : 1)

            Button("REFRESH") {
                refreshSiteStatus()
            }
            .padding(.top)
            .opacity(isChecking ? 0 : 1)
        }
        .animation(.spring, value: siteStatus.statusCode)
    }

    private var siteStatusText: LocalizedStringKey {
        switch siteStatus.statusCode {
        case .success:
            return "\(site.name)_IS_UP_AND_RUNNING"

        case .failure:
            return "TROUBLE_LOADING_\(site.name)"

        case .checking:
            return "CHECKING_\(site.name)"

        case .unknown:
            return "STATUS_OF_\(site.name)_IS_UNKNOWN"
        }
    }

}

#Preview("Success") {
    VStack {
        SiteStatusHeaderView(
            site: .preview,
            siteStatus: SiteStatus(statusCode: .success, time: 5),
            refreshSiteStatus: { }
        )
        Spacer()
    }
}

#Preview("Failure") {
    VStack {
        SiteStatusHeaderView(
            site: .preview,
            siteStatus: SiteStatus(statusCode: .failure(SiteStatusError(errorDescription: "Some error")), time: 5),
            refreshSiteStatus: { }
        )
        Spacer()
    }
}

#Preview("Checking") {
    VStack {
        SiteStatusHeaderView(
            site: .preview,
            siteStatus: SiteStatus(statusCode: .checking, time: 5),
            refreshSiteStatus: { }
        )
        Spacer()
    }
}

#Preview("Unknown") {
    VStack {
        SiteStatusHeaderView(
            site: .preview,
            siteStatus: SiteStatus(statusCode: .unknown, time: 5),
            refreshSiteStatus: { }
        )
        Spacer()
    }
}
