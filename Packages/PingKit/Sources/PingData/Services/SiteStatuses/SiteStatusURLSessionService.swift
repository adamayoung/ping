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

    public func siteStatus(using request: PingDomain.SiteStatusRequest) async -> PingDomain.SiteStatus {
        let url = request.url
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
        urlRequest.timeoutInterval = request.timeout

        let siteStatusCode: PingDomain.SiteStatus.Code
        let startTimestamp = Date.now
        do {
            let (_, response) = try await urlSession.data(for: urlRequest, delegate: self)
            siteStatusCode = Self.statusCode(for: response)
        } catch let error {
            let error = SiteStatusError(errorDescription: error.localizedDescription)
            siteStatusCode = .failure(error)
        }
        let endTimestamp = Date.now

        let time = endTimestamp.timeIntervalSince(startTimestamp)

        let status = PingDomain.SiteStatus(
            statusCode: siteStatusCode,
            time: time
        )

        return status
    }

}

extension SiteStatusURLSessionService {

    private static func statusCode(for response: URLResponse) -> PingDomain.SiteStatus.Code {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .unknown
        }

        guard isValidStatusCode(httpResponse.statusCode) else {
            let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            let error = SiteStatusError(errorDescription: errorDescription.capitalized)
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
