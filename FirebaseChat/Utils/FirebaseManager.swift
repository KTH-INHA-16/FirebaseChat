//
//  FirebaseManager.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/17.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

final class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    private override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}
