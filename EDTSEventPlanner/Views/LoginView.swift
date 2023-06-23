//
//  LoginView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @AppStorage("uid") var userID: String = ""
    @Binding var currentViewShowing: String
    @State private var email: String = ""
    @State private var password: String = ""
    @State var isNavigate: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    HStack{
                        Text("Login Page!")
                            .font(.largeTitle)
                            .padding()
                            .bold()
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "mail")
                        TextField("Email", text: $email)
                        
                        Spacer()
                        
                        if (email.count != 0){
                            Image(systemName:email.isValidEmail() ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(email.isValidEmail() ? .green : .red)
                        }
                    }
                    .padding()
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    HStack{
                        Image(systemName: "key")
                        SecureField("Password", text: $password)
                        
                        Spacer()
                        
                        if (password.count != 0){
                            Image(systemName: password.isValidPassword() ?  "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(password.isValidPassword() ? .green : .red)
                        }
                        
                        
                    }
                    .padding()
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    HStack{
                        Text("Don't have an account?")
                            .foregroundColor(.black.opacity(0.7))
                        Button {
                            withAnimation {
                                self.currentViewShowing = "register"
                            }
                        } label: {
                            Text("Sign up")
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if let error = error{
                                print(error)
                            }
                            
                            if let authResult = authResult {
                                print(authResult.user.uid)
                                userID = authResult.user.uid
                                isNavigate = true
                            }
                        }
                    } label: {
                        Text("Log in")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                            )
                            .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: HomeView(),
                                   isActive: self.$isNavigate, label: { EmptyView() })
                    
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var currentViewShowing = "login"
    
    static var previews: some View {
        LoginView(currentViewShowing: $currentViewShowing)
            .preferredColorScheme(.light)
    }
}
