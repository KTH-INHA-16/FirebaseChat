//
//  ChatBottomBarView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/23.
//

import SwiftUI

struct ChatBottomBarView: View {
    @ObservedObject var viewModel: ChatLogViewModel
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?, viewModel: ChatLogViewModel) {
        self.chatUser = chatUser
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 24))
                .foregroundColor(Color(uiColor: .darkGray))
            TextField("Description", text: $viewModel.chatText)
            Button(action: {
                viewModel.handleSend()
            }, label: {
                Text("Send")
                    .foregroundColor(.white)
            })
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemBlue))
            .cornerRadius(8)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct ChatBottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBottomBarView(chatUser: nil, viewModel: ChatLogViewModel(chatUser: nil))
    }
}
