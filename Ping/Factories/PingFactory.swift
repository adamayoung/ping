//
//  PingFactory.swift
//  Ping
//
//  Created by Adam Young on 10/11/2023.
//

import Foundation
import SwiftData

@MainActor
final class PingFactory {

    static let shared: PingFactoryProvider = {
        let appMode = AppMode()

        switch appMode {
        case .uiTest, .swiftUIPreview:
            return PingPreviewFactory()

        default:
            return PingLiveFactory()
        }
    }()

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
