//
//  SiteStatusCheckerService.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Foundation
import SwiftData

@Observable
final class SiteStatusCheckerService: NSObject {

    private(set) var checkingSites: [UUID] = []

    private let urlSession: URLSession

    init(urlSession: URLSession = .shared, checkingSites: [UUID] = []) {
        self.urlSession = urlSession
        self.checkingSites = checkingSites
    }

    func isChecking(site siteID: UUID) -> Bool {
        checkingSites.contains(siteID)
    }

    func checkSiteStatus(using requestTask: SiteRequestTask) async -> (SiteStatus.Code, TimeInterval) {
        await setIsChecking(true, for: requestTask.siteID)

        let siteStatusCode: SiteStatus.Code
        let startTimestamp = Date.now

        try? await Task.sleep(nanoseconds: 2_000_000_000)

        do {
            let (_, response) = try await urlSession.data(for: requestTask.urlRequest)
            siteStatusCode = Self.statusCode(for: response)
        } catch let error {
            siteStatusCode = .failure(error.localizedDescription)
        }
        let endTimestamp = Date.now

        let time = endTimestamp.timeIntervalSince(startTimestamp)

        await setIsChecking(false, for: requestTask.siteID)

        return (siteStatusCode, time)
    }

    @MainActor
    private func setIsChecking(_ isChecking: Bool, for siteID: UUID) {
        if isChecking {
            checkingSites.append(siteID)
        } else {
            checkingSites.removeAll { $0 == siteID }
        }
    }

}

extension SiteStatusCheckerService {

    private static func statusCode(for response: URLResponse) -> SiteStatus.Code {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .unknown
        }

        guard isValidStatusCode(httpResponse.statusCode) else {
            let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            return .failure(errorDescription.capitalized)
        }

        return .success
    }

    private static func isValidStatusCode(_ statusCode: Int) -> Bool {
        (200...299).contains(statusCode)
    }

}

extension SiteStatusCheckerService {

    static var preview: SiteStatusCheckerService {
        SiteStatusCheckerService(checkingSites: [Site.microsoftPreview.id])
    }

}
