//
//  AppDelegate.swift
//  Ping
//
//  Created by Adam Young on 31/10/2023.
//

#if os(iOS)
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        Self.checkForUITests(in: application)

        return true
    }

}

extension AppDelegate {

    private static func checkForUITests(in application: UIApplication) {
        guard ProcessInfo.isUITest else {
            return
        }

        if
            let scene = application.connectedScenes.first,
            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
            let window = windowSceneDelegate.window
        {
            window?.layer.speed = 200
        }

        UIView.setAnimationsEnabled(false)
    }

}
#endif
