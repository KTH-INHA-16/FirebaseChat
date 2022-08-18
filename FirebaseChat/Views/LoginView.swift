//
//  ContentView.swift
//  FirebaseChat
//
//  Created by 김태훈 on 2022/08/16.
//

import SwiftUI

struct LoginView: View {
    
    let didCompleteLoginProcess: () -> ()
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = false
    @State private var loginStatusMessage = ""
    @State private var image: UIImage? = nil
    @State private var shouldShowImagePicker = false
    
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
                            shouldShowImagePicker.toggle()
                        }, label: {
                            
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 128, height: 128)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(Color(.label))
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black, lineWidth: 3))
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
                    
                    Text(loginStatusMessage)
                        .foregroundColor(.red)
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
        .navigationViewStyle(.stack)
        .fullScreenCover(isPresented: $shouldShowImagePicker, content: {
            ImagePicker(image: $image)
        })
    }
}

private extension LoginView {
    func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    func createNewAccount() {
        if self.image == nil {
            self.loginStatusMessage = "You must select an avatar image"
            return
        }
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                loginStatusMessage = "Failed to create User: \(error)"
                return
            }
            
            loginStatusMessage = "Successfully create User: \(result?.user.uid ?? "")"
            persistImageToStorage()
        }
    }
    
    func loginUser() {
        if FirebaseManager.shared.auth.isSignIn(withEmailLink: email) {
            try? FirebaseManager.shared.auth.signOut()
            return
        }
        
        FirebaseManager.shared.auth.signIn(withEmail: email, link: password) { result, error in
            if let error = error {
                loginStatusMessage = "Failed to login User: \(error)"
                return
            }
            loginStatusMessage = "Successfully login User: \(result?.user.uid ?? "")"
            
            self.didCompleteLoginProcess()
        }
    }
    
    func persistImageToStorage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid, let imageData = self.image?.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        let reference = FirebaseManager.shared.storage.reference(withPath: uid)
        reference.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                self.loginStatusMessage = "Failed to push image to Storage: \(error)"
                return
            }
            
            reference.downloadURL { response in
                switch response {
                case .success(let url):
                    self.loginStatusMessage = "Successfully stored image with url: \(url.absoluteString)"
                    storeUserInformation(url: url)
                case .failure(let error):
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(error)"
                }
            }
        }
    }
    
    func storeUserInformation(url imageURL: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        let userData = ["email": self.email, "uid" : uid, "imageURL" : imageURL.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { error in
                if let error = error {
                    self.loginStatusMessage = "\(error)"
                    return
                }
                
                self.didCompleteLoginProcess()
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didCompleteLoginProcess: {
            
        })
    }
}
