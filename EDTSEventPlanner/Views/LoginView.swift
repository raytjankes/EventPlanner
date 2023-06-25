//
//  LoginView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var language: LanguageViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @AppStorage("uid") var userID: String = ""
    @Binding var currentViewShowing: String
    @State private var email: String = ""
    @State private var password: String = ""
    @State var isNavigate: Bool = false
    @State var isSecured: Bool = true
    
    var body: some View {
        NavigationView {
            GeometryReader{geometry in
                ZStack{
                    VStack{
                        HStack{
                            Spacer()
                            
                            ChangeLanguageView()
                        }
                        Spacer()
                    }
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
                                Text("label_email".localized(language.getLanguage()) +  ":")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.customPrimary)
                                Spacer()

                            }
                            .padding(.horizontal)
                            HStack{
                                Image(systemName: "mail")
                                TextField("label_email".localized(language.getLanguage()), text: $email)
                                    .onChange(of: email) { newEmail in
                                            authViewModel.checkAuthenticationInput(email: newEmail, password: password)
                                    }
                                
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
                                Text("label_password".localized(language.getLanguage())+":")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.customPrimary)
                                Spacer()

                            }
                            .padding(.horizontal)
                            HStack{
                                Button {
                                    isSecured.toggle()
                                } label: {
                                    Image(systemName: isSecured ? "eye.slash"  : "eye")
                                        .foregroundColor(Color.customDarkBackground)
                                }
                                if(isSecured == true){
                                    SecureField("label_password".localized(language.getLanguage()), text: $password)
                                        .onChange(of: password) { newPassword in
                                                authViewModel.checkAuthenticationInput(email: email, password: newPassword)
                                        }
                                }
                                else{
                                    TextField("label_password".localized(language.getLanguage()), text: $password)
                                        .onChange(of: password) { newPassword in
                                                authViewModel.checkAuthenticationInput(email: email, password: newPassword)
                                        }
                                }
                                
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
                            Text("label_login_redirect_register".localized(language.getLanguage()))
                                .foregroundColor(Color.customPrimary.opacity(0.7))
                            Button {
                                withAnimation {
                                    self.currentViewShowing = "register"
                                }
                            } label: {
                                Text("button_login_redirect_register".localized(language.getLanguage()))
                                    .foregroundColor(Color.customButton)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        if (!authViewModel.authenticationSuccess) {
                            Text(authViewModel.errorMessage)
                                .foregroundColor(Color.customDisabledButton)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                        Button {
                            authViewModel.login(email: email, password: password) { userID in
                                DispatchQueue.main.async {
                                    if !userID.contains("Failure") {
                                        self.userID = userID
                                        authViewModel.authenticationSuccess = true
                                        isNavigate = true
                                    }
                                    else{
                                        authViewModel.authenticationSuccess = false
                                    }
                                }
                            }

                        } label: {
                            Text("button_login_redirect_home".localized(language.getLanguage()))
                                .foregroundColor(Color.customPrimary)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(authViewModel.validAuthenticationInput ? Color.customButton : Color.customDisabledButton)
                                        .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 2)
                                )
                                .padding(.horizontal)
                        }
                        .disabled(!authViewModel.validAuthenticationInput)
                        
                    }
                }.background(Color.customBackground)
            }
            NavigationLink(destination: HomeView(),
                           isActive: self.$isNavigate, label: { EmptyView() })
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var currentViewShowing = "login"
    
    static var previews: some View {
        LoginView(currentViewShowing: $currentViewShowing)
            .environmentObject(LanguageViewModel())
            .environmentObject(AuthViewModel())
    }
}
