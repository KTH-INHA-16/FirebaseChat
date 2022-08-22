//
//  CreateNewMessageView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/22.
//

import SwiftUI

struct CreateNewMessageView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = CreateNewMessageViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.users) { user in
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            AsyncImage(url: URL(string: user.imageURL), content: { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color(.label), lineWidth: 1))
                                default:
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 50, weight: .heavy))
                                        .overlay(RoundedRectangle(cornerRadius: 44)
                                            .stroke(Color(.label), lineWidth: 1))
                                }
                            })
                            
                            Text(user.email)
                                .foregroundColor(Color(.label))
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.vertical, 8)
                    })
                }
                .navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading,
                                     content: {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack(spacing: -1) {
                            Label("Cancel", systemImage: "chevron.left")
                            Text("Cancel")
                            }
                        })
                    })
                }
            }
        }
    }
}

struct CreateNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewMessageView()
    }
}
