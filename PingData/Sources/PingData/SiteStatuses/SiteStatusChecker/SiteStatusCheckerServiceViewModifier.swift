//
//  File.swift
//  
//
//  Created by Adam Young on 20/02/2024.
//

import SwiftData
import SwiftUI

struct SiteStatusCheckerServiceViewModifier: ViewModifier {

    @Environment(\.modelContext) private var modelContext

    @MainActor private static let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        #if !os(macOS)
        configuration.multipathServiceType = .handover
        #endif

        return URLSession(configuration: configuration)
    }()

    @MainActor private static let previewURLSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        URLProtocolMock.responseConfigs = [
            URL.google: (
                HTTPURLResponse(url: URL.google, statusCode: 500, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.gitHub: (
                HTTPURLResponse(url: URL.google, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.twitter: (
                HTTPURLResponse(url: URL.twitter, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            ),
            URL.microsoft: (
                HTTPURLResponse(url: URL.microsoft, statusCode: 200, httpVersion: "2.0", headerFields: nil),
                nil
            )
        ]
        configuration.protocolClasses = [URLProtocolMock.self]

        return URLSession(configuration: configuration)
    }()

    private let service: SiteStatusCheckerService

    init(preview: Bool) {
        self.service = SiteStatusCheckerService(urlSession: preview ? Self.previewURLSession : Self.urlSession)
    }

    func body(content: Content) -> some View {
        content
            .environment(service)
            .onReceive(service.siteStatusPublisher) { statusResult in
                addStatusResult(statusResult)
            }
    }

    private func addStatusResult(_ statusResult: SiteStatusResult) {
            let siteID = statusResult.siteID
            var fetchDescriptor = FetchDescriptor<Site>(predicate: #Predicate { $0.id == siteID })
            fetchDescriptor.fetchLimit = 1
    
            guard let site = try? modelContext.fetch(fetchDescriptor).first else {
                return
            }
    
            let status = SiteStatus(statusCode: statusResult.siteStatusCode, time: statusResult.time)
            withAnimation {
                if site.statuses == nil {
                    site.statuses = []
                }
    
                site.statuses?.append(status)
            }
    
            do {
                try modelContext.save()
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }

}

public extension View {

    func siteStatusCheckerService(preview: Bool = false) -> some View {
        modifier(SiteStatusCheckerServiceViewModifier(preview: preview))
    }

}
