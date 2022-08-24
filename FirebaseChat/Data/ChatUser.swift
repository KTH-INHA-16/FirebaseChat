//
//  ChatUser.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/18.
//

import Foundation

struct ChatUser: Identifiable {
    var id: String { uid }
    
    let uid, email, imageURL: String
    
    init(data: [String: Any]) {
        (uid, email, imageURL) = (data[FirebaseConstants.uid] as? String ?? "", data[FirebaseConstants.email] as? String ?? "", data[FirebaseConstants.imageURL] as? String ?? "")
    }
}
