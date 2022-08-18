//
//  CustomNavBar.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/18.
//

import SwiftUI

struct CustomNavBar: View {
    @Binding var shouldShowLogOutOptions: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("UserName")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            
            Spacer()
            Button(action: {
                shouldShowLogOutOptions.toggle()
            }, label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            })
        }
        .padding()
        .confirmationDialog("What do you want to do?", isPresented: $shouldShowLogOutOptions, titleVisibility: .visible, actions: {
            Button("Sign Out", role: .destructive, action: {
                
            })
        })
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(shouldShowLogOutOptions: .constant(false))
    }
}
