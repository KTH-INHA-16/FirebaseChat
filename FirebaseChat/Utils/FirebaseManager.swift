//
//  FirebaseManager.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/17.
//

import Foundation
import Firebase
import FirebaseStorage

final class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    private override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        
        super.init()
    }
}
