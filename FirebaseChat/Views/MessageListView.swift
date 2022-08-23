//
//  MessageView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/18.
//

import SwiftUI

struct MessageListView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { _ in
                VStack {
                    NavigationLink(destination: {
                        Text("fff")
                    }, label: {
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color(.label), lineWidth: 1))
                            
                            VStack(alignment: .leading) {
                                Text("user name")
                                    .font(.system(size: 16, weight: .bold))
                                Text("sent to user")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(.lightGray))
                            }
                            Spacer()
                            
                            Text("22d")
                                .font(.system(size: 14, weight: .semibold))
                            
                        }
                        
                    })
                    
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 50)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView()
    }
}
