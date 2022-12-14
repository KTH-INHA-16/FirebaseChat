//
//  FirebaseChatApp.swift
//  FirebaseChat
//
//  Created by κΉνν on 2022/08/16.
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
            MainMessagesView()
        }
    }
}
