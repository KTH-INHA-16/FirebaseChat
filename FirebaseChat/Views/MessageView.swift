//
//  MessageView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/24.
//

import SwiftUI

struct MessageView: View {
    @Binding var message: ChatMessage
    
    var body: some View {
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
}

struct TempMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: .constant(ChatMessage(documentId: "", data: [:])))
    }
}
