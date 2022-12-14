//
//  ChatLogViewModel.swift
//  FirebaseChat
//
//  Created by κΉνν on 2022/08/24.
//

import Foundation
import Combine
import Firebase

final class ChatLogViewModel: ObservableObject {
    @Published var chatText = ""
    @Published var errorMessage = ""
    @Published var count = 0
    @Published var chatMessages: [ChatMessage] = []
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
}

private extension ChatLogViewModel {
    func fetchMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid, let toId = chatUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    return
                }
                
                querySnapshot?.documentChanges
                    .filter {
                        $0.type == .added
                    }.forEach { [weak self] in
                        let data = $0.document.data()
                        let docId = $0.document.documentID
                        self?.chatMessages.append(.init(documentId: docId, data: data))
                    }
                
                DispatchQueue.main.async {
                    self.count += 1
                }
            }
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
            self.count += 1
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
