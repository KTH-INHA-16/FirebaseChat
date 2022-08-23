//
//  ChatLogView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/23.
//

import SwiftUI

struct ChatLogView: View {
    @Binding var chatUser: ChatUser?
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) {
                Text("\($0)")
            }
        }
        .navigationTitle(chatUser?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(chatUser: .constant(nil))
    }
}
