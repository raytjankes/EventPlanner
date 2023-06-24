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
                        HStack{
                            //                            Text("welcome_message".localized(language.getLanguage()))
                            //                                .font(.largeTitle)
                            //                                .padding()
                            //                                .bold()
                            //                                .accessibility(label: Text("welcome_message".localized(language.getLanguage())))
                            
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
                                TextField("Email Address", text: $email)
                                
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
                            Text("Don't have an account?")
                                .foregroundColor(Color.customPrimary.opacity(0.7))
                            Button {
                                withAnimation {
                                    self.currentViewShowing = "register"
                                }
                            } label: {
                                Text("Sign up")
                                    .foregroundColor(Color.customButton)
                            }
                        }
                        .padding()
                        
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
                                        .foregroundColor(Color.customButton)
                                        .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 2)
                                )
                                .padding(.horizontal)
                        }
                        
                    }
                } .onChange(of: language.language) { _ in
                    // Reload the view when the language changes
                    // You can add any necessary logic here to handle view refresh
                    currentViewShowing = currentViewShowing // Force a refresh by updating the binding value
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
            .preferredColorScheme(.light)
            .environmentObject(LanguageViewModel())
    }
}
