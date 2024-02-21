//
//  File.swift
//  
//
//  Created by Adam Young on 20/02/2024.
//

import SwiftData
import SwiftUI

public struct SiteModelPreview<Content: View>: View {

    var id: Site.ID?
    var content: (Site) -> Content

    public init(id: Site.ID? = nil, @ViewBuilder content: @escaping (Site) -> Content) {
        self.id = id
        self.content = content
    }

    public var body: some View {
        PreviewContentView(content: content)
    }

    struct PreviewContentView: View {

        var siteID: Site.ID?
        var content: (Site) -> Content

//        private static var sitesFetchDescriptor: FetchDescriptor<Site> {
//            guard let siteID else {
//                return FetchDescriptor<Site>()
//            }
//
//            var descriptor = FetchDescriptor<Site>(predicate: #Predicate<Site> { site in
//                site.id = siteID
//            }}
//            return descriptor
//        }

        @Query private var models: [Site]
        @State private var waitedToShowIssue = false

        var body: some View {
            if let model = models.first {
                content(model)
            } else {
                ContentUnavailableView {
                    Label {
                        Text(verbatim: "Could not load model for previews")
                    } icon: {
                        Image(systemName: "xmark")
                    }
                }
                .opacity(waitedToShowIssue ? 1 : 0)
                .task {
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        waitedToShowIssue = true
                    }
                }
            }
        }
    }
}
