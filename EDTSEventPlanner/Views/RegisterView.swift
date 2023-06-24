//
//  RegisterView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    
    @EnvironmentObject var language: LanguageViewModel
    @AppStorage("uid") var userID: String = ""
    @Binding var currentViewShowing: String
    @State private var email: String = ""
    @State private var password: String = ""
    @State var isNavigate: Bool = false

    var body: some View {
        NavigationView {
            GeometryReader{geometry in
                ZStack{

                    VStack{
                        Image("edts-logo-png")
                            .resizable()
                            .padding()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: geometry.size.height/3)
                        
                        Spacer()
                            .frame(height: geometry.size.height / 20)
                        VStack{
                            HStack{
                                Text("Email Address:")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.customPrimary)
                                Spacer()
                                
                            }
                            .padding(.horizontal)
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
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.customPrimary)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 4)
                                    .foregroundColor(Color.customDarkBackground)
                                    .shadow(color: Color.customDarkBackground, radius: 3, x: 0, y: 3)
                            )
                            .padding(.horizontal)
                        }
                        Spacer().frame(height: geometry.size.height / 30)
                        VStack{
                            HStack{
                                Text("Password:")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.customPrimary)
                                Spacer()
                                
                            }
                            .padding(.horizontal)
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
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.customPrimary)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 4)
                                    .foregroundColor(Color.customDarkBackground)
                                    .shadow(color: Color.customDarkBackground, radius: 3, x: 0, y: 3)
                            )
                            .padding(.horizontal)
                        }
                        
                        HStack{
                            Text("Already have an account?")
                                .opacity(0.7)
                            Button {
                                withAnimation {
                                    self.currentViewShowing = "login"
                                }
                                
                            } label: {
                                Text("Log in")
                                    .foregroundColor(Color.customButton)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button {
                            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                
                                if let error = error {
                                    print( error)
                                    return
                                }
                                if let authResult = authResult {
                                    print(authResult.user.uid)
                                    userID = authResult.user.uid
                                    isNavigate = true
                                }
                            }
                            
                        } label: {
                            Text("Register")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.customButton)
                                        .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 2)
                                )
                                .padding(.horizontal)
                        }
                        
                        NavigationLink(destination: HomeView(),
                                       isActive: self.$isNavigate, label: { EmptyView() })
                        
                    }
                    VStack{
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                // Change the language
                                language.toggleLanguage()
                            }) {
                                Text(language.getLanguage().rawValue)
                                    .padding()
                                    .fontWeight(.bold)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(Color.customButton)
                                            .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 2)
                                    )
                                    .foregroundColor(Color.customPrimary)
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
                .background(Color.customDarkBackground)

            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    @State static var currentViewShowing = "register"
    
    static var previews: some View {
        RegisterView(currentViewShowing: $currentViewShowing)
            .environmentObject(LanguageViewModel())
            .preferredColorScheme(.dark)
        
    }
}
