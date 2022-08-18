//
//  MainMessagesView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/17.
//

import SwiftUI

struct MainMessagesView: View {
    @State private var shouldShowLogOutOptions = false
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar(shouldShowLogOutOptions: $shouldShowLogOutOptions)
                
                MessageListView()
            }
            .overlay(NewMessageButton(), alignment: .bottom)
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
