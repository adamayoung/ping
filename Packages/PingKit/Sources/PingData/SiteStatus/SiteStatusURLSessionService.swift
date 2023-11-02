//
//  SiteCheckURLSessionService.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

public final class SiteStatusURLSessionService: NSObject, SiteStatusService {

    private let urlSession: URLSession

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func check(site: PingDomain.Site) async -> PingDomain.SiteStatus {
        let url = site.url
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        urlRequest.timeoutInterval = 5

        let siteStatusCode: PingDomain.SiteStatusCode
        do {
            let (_, response) = try await urlSession.data(for: urlRequest, delegate: self)
            siteStatusCode = Self.statusCode(for: response)
        } catch let error {
            let error = SiteStatusError(errorDescription: error.localizedDescription)
            siteStatusCode = .failure(error)
        }

        let status = PingDomain.SiteStatus(
            siteID: site.id,
            statusCode: siteStatusCode
        )

        return status
    }

}

extension SiteStatusURLSessionService {

    private static func statusCode(for response: URLResponse) -> PingDomain.SiteStatusCode {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .unknown
        }

        guard isValidStatusCode(httpResponse.statusCode) else {
            let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            let error = SiteStatusError(errorDescription: errorDescription)
            return .failure(error)
        }

        return .success
    }

    private static func isValidStatusCode(_ statusCode: Int) -> Bool {
        (200...299).contains(statusCode)
    }

}

extension SiteStatusURLSessionService: URLSessionTaskDelegate {

    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping @Sendable (URLRequest?) -> Void
    ) {
        completionHandler(request)
    }

}
