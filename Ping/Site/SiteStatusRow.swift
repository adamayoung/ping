//
//  SiteStatusRow.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import SwiftData
import SwiftUI

struct SiteStatusRow: View {

    var status: SiteStatus

    private var formattedTimestamp: String {
        status.timestamp.formatted(date: .numeric, time: .shortened)
    }

    var body: some View {
        Label(
            title: {
                VStack(alignment: .leading) {
                    Text(status.statusCode.localizedName)

                    if case let .failure(message) = status.statusCode {
                        Text(verbatim: message)
                            .font(.caption)
                            .foregroundStyle(Color.secondary)
                    }

                    Text("\(Image(systemName: "clock")) \(formattedTimestamp)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            },
            icon: {
                Image(systemName: status.statusCode.iconName)
                    .foregroundStyle(status.statusCode.iconColor)
            }
        )
    }

}

#Preview {
    let modelContainer = ModelContainer.preview
    let statuses = Site.gitHubPreview.statuses ?? []

    return List {
        ForEach(statuses) { status in
            SiteStatusRow(status: status)
        }
    }
    .modelContainer(modelContainer)

}
