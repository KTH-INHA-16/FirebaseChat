//
//  ChatMessage.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/24.
//

import Foundation

struct FirebaseConstants {
    static let fromId = "fromId"
    static let toId = "toId"
    static let text = "text"
    static let uid = "uid"
    static let email = "email"
    static let imageURL = "imageURL"
}

struct ChatMessage: Identifiable {
    var id: String { documentId }
    
    let documentId: String
    let fromId, toId, text: String
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        (fromId, toId, text) = (data[FirebaseConstants.fromId] as? String ?? "", data[FirebaseConstants.toId] as? String ?? "", data[FirebaseConstants.text] as? String ?? "")
    }
}
