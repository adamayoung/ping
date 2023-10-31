//
//  SiteRow.swift
//  Ping
//
//  Created by Adam Young on 30/10/2023.
//

import PingKit
import SwiftUI

struct SiteRow: View {

    var site: Site
    var siteStatus: SiteStatus

    var body: some View {
        Label {
            labelTitle
        } icon: {
            switch siteStatus.statusCode {
            case .checking:
                ProgressView()
                    .controlSize(.small)

            default:
                Image(systemName: iconName)
                    .foregroundStyle(iconColor)
            }
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
    return NavigationStack {
        List {
            NavigationLink(destination: EmptyView()) {
                SiteRow(site: Site.previews[0], siteStatus: .preview(.success))
            }
            SiteRow(
                site: Site.previews[1],
                siteStatus: .preview(.failure(SiteStatusError(errorDescription: "Some error")))
            )
            SiteRow(site: Site.previews[2], siteStatus: .preview(.checking))
            SiteRow(site: .preview, siteStatus: .preview(.unknown))
        }
#if os(macOS)
        .listStyle(.sidebar)
#endif
    }
}
