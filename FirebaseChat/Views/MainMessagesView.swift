//
//  MainMessagesView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/17.
//

import SwiftUI

struct MainMessagesView: View {
    @StateObject private var viewModel = MainMessagesViewModel()
    @State private var shouldShowLogOutOptions = false
    @State private var shouldShowNewMessageScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar(viewModel: viewModel, shouldShowLogOutOptions: $shouldShowLogOutOptions)
                
                MessageListView()
            }
            .overlay(NewMessageButton(shouldShowNewMessageScreen: $shouldShowNewMessageScreen), alignment: .bottom)
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
