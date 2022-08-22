//
//  CreateNewMessageViewModel.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/22.
//

import Foundation
import Combine

final class CreateNewMessageViewModel: ObservableObject {
    
    @Published var users: [ChatUser] = []
    
    init() {
        fetchAllUsers()
    }
}

private extension CreateNewMessageViewModel {
    func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentSnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                documentSnapshot?.documents.forEach { [weak self] snapshot in
                    let data = snapshot.data()
                    let user = ChatUser(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self?.users.append(.init(data: data))
                    }
                }
            }
    }
}
