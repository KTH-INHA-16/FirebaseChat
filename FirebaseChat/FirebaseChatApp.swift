//
//  FirebaseChatApp.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/16.
//

import SwiftUI
import FirebaseCore

@main
struct FirebaseChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
