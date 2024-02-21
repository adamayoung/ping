//
//  SiteStatusCheckerService.swift
//  Ping
//
//  Created by Adam Young on 09/11/2023.
//

import Combine
import SwiftData
import SwiftUI

@Observable
public final class SiteStatusCheckerService: NSObject {

    public var siteStatusPublisher: AnyPublisher<SiteStatusResult, Never> {
        siteStatusSubject
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    private(set) var checkingSites: [UUID]

    private let urlSession: URLSession
    private let siteStatusSubject = PassthroughSubject<SiteStatusResult, Never>()

    public convenience init(urlSession: URLSession = .shared) {
        self.init(
            urlSession: urlSession,
            checkingSites: []
        )
    }

    private init(urlSession: URLSession, checkingSites: [UUID]) {
        self.urlSession = urlSession
        self.checkingSites = checkingSites
    }

    public func isChecking(site siteID: UUID) -> Bool {
        checkingSites.contains(siteID)
    }

    public func checkSiteStatus(using requestTask: SiteStatusRequestTask) async {
        await setIsChecking(true, for: requestTask.siteID)

        let siteStatusCode: SiteStatus.Code
        let startTimestamp = Date.now

        do {
            let (_, response) = try await urlSession.data(for: requestTask.urlRequest)
            siteStatusCode = Self.statusCode(for: response)
        } catch let error {
            siteStatusCode = .failure(error.localizedDescription)
        }
        let endTimestamp = Date.now

        let time = endTimestamp.timeIntervalSince(startTimestamp)

        await setIsChecking(false, for: requestTask.siteID)

        let result = SiteStatusResult(siteID: requestTask.siteID, siteStatusCode: siteStatusCode, time: time)

        siteStatusSubject.send(result)
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

    private static let validHTTPStatusCodes = 200...299

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
        validHTTPStatusCodes.contains(statusCode)
    }

}
