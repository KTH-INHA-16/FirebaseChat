//
//  MessagesView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/23.
//

import SwiftUI

struct MessagesView: View {
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) { num in
                
                HStack {
                    Spacer()
                    
                    HStack {
                        Text("\(num)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
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
            ChatBottomBarView(chatUser: self.chatUser)
                .background(Color(.systemBackground)
                    .ignoresSafeArea())
        })
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatUser: nil)
    }
}
