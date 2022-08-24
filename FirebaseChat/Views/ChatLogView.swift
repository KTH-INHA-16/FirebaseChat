//
//  ChatLogView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/23.
//

import SwiftUI

struct ChatLogView: View {
    var chatUser: ChatUser?
    @ObservedObject var viewModel: ChatLogViewModel
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        viewModel = ChatLogViewModel(chatUser: chatUser)
    }
    
    var body: some View {
        ZStack {
            MessagesView(chatUser: chatUser)
            Text(viewModel.errorMessage)
        }
        .navigationTitle(chatUser?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(chatUser: nil)
    }
}
