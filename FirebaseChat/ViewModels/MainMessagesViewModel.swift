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
    @Published var isUserCurrentlyLoggedOut = false
    
    init() {
        fetchCurrentUser()
    }
}

extension MainMessagesViewModel {
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            DispatchQueue.main.async {
                self.isUserCurrentlyLoggedOut.toggle()
            }
            return
        }
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .getDocument { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = snapshot?.data() else {
                    return
                }
                
                self?.chatUser = ChatUser(data: data)
            }
    }
}
