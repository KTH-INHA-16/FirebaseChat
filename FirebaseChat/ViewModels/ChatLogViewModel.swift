//
//  ChatLogViewModel.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/24.
//

import Foundation
import Combine
import Firebase

final class ChatLogViewModel: ObservableObject {
    @Published var chatText = ""
    @Published var errorMessage = ""
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
}

extension ChatLogViewModel {
    func handleSend() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid, let toId = chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData: [String: Any] = ["fromId": fromId, "toId": toId, "text": self.chatText, "timestamp": Timestamp()]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error.localizedDescription)"
                return
            }
            self.errorMessage.removeAll()
            self.chatText.removeAll()
        }
        
        let recipientMessageDocument = FirebaseManager.shared.firestore
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error.localizedDescription)"
                return
            }
            self.errorMessage.removeAll()
            self.chatText.removeAll()
        }
    }
}
