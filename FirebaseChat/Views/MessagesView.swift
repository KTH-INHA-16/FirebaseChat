//
//  MessagesView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/23.
//

import SwiftUI

struct MessagesView: View {
    static let emptyScrollToString = "Empty"
    let chatUser: ChatUser?
    @ObservedObject var viewModel: ChatLogViewModel
    
    init(chatUser: ChatUser?, viewModel: ChatLogViewModel) {
        self.chatUser = chatUser
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(viewModel.chatMessages) { message in
                        MessageView(message: .constant(message))
                    }
                    
                    HStack {
                        Spacer()
                    }.id(Self.emptyScrollToString)
                }.onReceive(viewModel.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo("Empty", anchor: .bottom)
                    }
                }
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
        .safeAreaInset(edge: .bottom, content: {
            ChatBottomBarView(chatUser: self.chatUser, viewModel: self.viewModel)
                .background(Color(.systemBackground)
                    .ignoresSafeArea())
        })
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatUser: nil, viewModel: ChatLogViewModel(chatUser: nil))
    }
}
