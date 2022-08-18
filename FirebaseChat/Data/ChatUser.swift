//
//  ChatUser.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/18.
//

import Foundation

struct ChatUser {
    let uid, email, imageURL: String
    
    init(data: [String: Any]) {
        (uid, email, imageURL) = (data["uid"] as? String ?? "", data["email"] as? String ?? "", data["imageURL"] as? String ?? "")
    }
}
