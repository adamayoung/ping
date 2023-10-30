//
//  SiteCheckURLSessionService.swift
//  PingData
//
//  Created by Adam Young on 29/10/2023.
//

import Foundation
import PingDomain

public final class SiteStatusURLSessionService: SiteStatusService {

    private let urlSession: URLSession

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func check(site: PingDomain.Site) async throws -> PingDomain.SiteStatus {
        let url = site.url
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)

        let (_, response) = try await urlSession.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            return .unknown
        }

        guard isValidStatusCode(httpResponse.statusCode) else {
            return .failure
        }

        return .success
    }

}

extension SiteStatusURLSessionService {

    private func isValidStatusCode(_ statusCode: Int) -> Bool {
        (200...299).contains(statusCode)
    }

}
