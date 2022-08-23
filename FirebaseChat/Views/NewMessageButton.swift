//
//  newMessageButton.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/18.
//

import SwiftUI

struct NewMessageButton: View {
    @Binding var shouldShowNewMessageScreen: Bool
    @Binding var chatUser: ChatUser?
    
    var body: some View {
        Button(action: {
            shouldShowNewMessageScreen.toggle()
        }, label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        })
        .fullScreenCover(isPresented: $shouldShowNewMessageScreen, content: {
            CreateNewMessageView { user in
                self.chatUser = user
            }
        })
    }
}

struct newMessageButton_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageButton(shouldShowNewMessageScreen: .constant(false), chatUser: .constant(nil))
    }
}
