//
//  MainMessagesViewModel.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/18.
//

import Foundation
import Combine

final class MainMessagesViewModel: ObservableObject {
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
}

private extension MainMessagesViewModel {
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .getDocument { [weak self] snapshot, error in
                guard error != nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                guard let data = snapshot?.data() else {
                    return
                }
                
                let (uid, email, imageURL) = (data["uid"] as? String ?? "", data["email"] as? String ?? "", data["imageURL"] as? String ?? "")
                self?.chatUser = ChatUser(uid: uid, email: email, imageURL: imageURL)
            }
    }
}
