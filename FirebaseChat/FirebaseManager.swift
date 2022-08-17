//
//  FirebaseManager.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/17.
//

import Foundation
import Firebase

final class FirebaseManager: NSObject {
    let auth: Auth
    
    static let shared = FirebaseManager()
    
    private override init() {
        self.auth = Auth.auth()
        
        super.init()
    }
}
