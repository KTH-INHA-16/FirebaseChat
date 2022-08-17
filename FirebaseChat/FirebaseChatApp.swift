//
//  FirebaseChatApp.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/16.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FirebaseChatApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
