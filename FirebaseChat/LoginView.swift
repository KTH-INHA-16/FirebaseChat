//
//  ContentView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/16.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoginMode = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode,
                           content: {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }, label: {
                        Text("Picker Here")
                    })
                    .pickerStyle(.segmented)
                    
                    if !isLoginMode {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        })
                    }

                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(.white)
                
                    Button(action: {
                        handleAction()
                    }, label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        .background(.blue)
                    })
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
}

private extension LoginView {
    func handleAction() {
        if isLoginMode {
            print("Should log into Firebase with existing credentials")
        } else {
            print("blabla")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
