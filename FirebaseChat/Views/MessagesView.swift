//
//  MessagesView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/23.
//

import SwiftUI

struct MessagesView: View {
    let chatUser: ChatUser?
    @ObservedObject var viewModel: ChatLogViewModel
    
    init(chatUser: ChatUser?, viewModel: ChatLogViewModel) {
        self.chatUser = chatUser
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.chatMessages) { message in
                
                VStack {
                    if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                        HStack {
                            Spacer()
                            
                            HStack {
                                Text(message.text)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color(.systemBlue))
                            .cornerRadius(8)
                        }
                    } else {
                        HStack {
                            HStack {
                                Text(message.text)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(8)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            
            HStack {
                Spacer()
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
