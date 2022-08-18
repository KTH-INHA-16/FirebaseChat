//
//  CustomNavBar.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/18.
//

import SwiftUI

struct CustomNavBar: View {
    @StateObject var viewModel: MainMessagesViewModel
    @Binding var shouldShowLogOutOptions: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: viewModel.chatUser?.imageURL ?? ""), content: { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1))
                        .shadow(radius: 5)
                default:
                    Image(systemName: "person.fill")
                        .font(.system(size: 50, weight: .heavy))
                        .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1))
                        .shadow(radius: 5)
                }
            })
            
            VStack(alignment: .leading, spacing: 4) {
                let email = viewModel.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? ""
                Text(email)
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
                viewModel.handleSignOut()
            })
        })
        .fullScreenCover(isPresented: $viewModel.isUserCurrentlyLoggedOut, content: {
            LoginView(didCompleteLoginProcess: {
                self.viewModel.isUserCurrentlyLoggedOut = false
                self.viewModel.fetchCurrentUser()
            })
        })
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(viewModel: MainMessagesViewModel(), shouldShowLogOutOptions: .constant(false))
    }
}
