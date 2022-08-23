//
//  MainMessagesView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/17.
//

import SwiftUI

struct MainMessagesView: View {
    @StateObject private var viewModel = MainMessagesViewModel()
    @State var shouldShowLogOutOptions = false
    @State var shouldShowNewMessageScreen = false
    @State var shouldNavigateToChatLogView = false
    @State var chatUser: ChatUser?
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar(viewModel: viewModel, shouldShowLogOutOptions: $shouldShowLogOutOptions)
                
                MessageListView()
                
                NavigationLink("",
                               isActive: $shouldNavigateToChatLogView,
                               destination: {
                    ChatLogView(chatUser: $chatUser)
                })
            }
            .overlay(NewMessageButton(shouldShowNewMessageScreen: $shouldShowNewMessageScreen,
                                      chatUser: $chatUser),
                     alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
            .preferredColorScheme(.dark)
        
        MainMessagesView()
    }
}
