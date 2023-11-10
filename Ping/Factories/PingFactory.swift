//
//  PingFactory.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation
import SwiftData

@MainActor
final class PingFactory: PingFactoryProvider {

    static let shared = PingFactory()

    private let appMode = AppMode()
    private let liveFactory: PingFactoryProvider
    private let previewFactory: PingFactoryProvider

    private var factory: PingFactoryProvider {
        switch appMode {
        case .swiftUIPreview:
            return previewFactory

        case .uiTest:
            return previewFactory

        default:
            return liveFactory
        }
    }

    private init(
        liveFactory: PingFactoryProvider = PingLiveFactory.shared,
        previewFactory: PingFactoryProvider = PingPreviewFactory.shared
    ) {
        self.liveFactory = liveFactory
        self.previewFactory = previewFactory
    }

    var modelContainer: ModelContainer {
        factory.modelContainer
    }

    var siteStatusCheckerService: SiteStatusCheckerService {
        factory.siteStatusCheckerService
    }

}

extension PingFactory {

    private enum AppMode {
        case live
        case swiftUIPreview
        case uiTest

        init() {
            if ProcessInfo.isSwiftUIPreview {
                self = .swiftUIPreview
                return
            }

            if ProcessInfo.isUITest {
                self = .uiTest
                return
            }

            self = .live
        }
    }

}
