//
//  ProfileView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @AppStorage("uid") var userID: String = ""
    @EnvironmentObject var language: LanguageViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                ZStack{
                    VStack{
                        HStack{
                            NavigationLink(destination: HomeView()) {
                                Image(systemName: "arrowshape.backward.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.customPrimary)
                            }.padding()
                            Spacer()
                        }
                        .padding(.bottom)
                        .background(Color.customBackground)
                        Spacer()
                    }
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text("title_profile_header".localized(language.getLanguage()))
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color.customPrimary)
                                .padding(.top)
                            Spacer()
                        }
                        Spacer().frame(height: geometry.size.height / 10)
                        
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 200))
                            .foregroundColor(Color.customSecondary)
                        
                        Spacer().frame(height: geometry.size.height / 25)
                        
                        Text(authViewModel.getCurrentUserEmail() ?? "Stranger")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(Color.customDarkBackground)
                        
                        Spacer().frame(height: geometry.size.height / 10)
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
                        Spacer().frame(height: geometry.size.height / 10)
                        HStack{
                            Spacer()
                            Button {
                                authViewModel.logout { message in
                                    if message == "Success"{
                                        userID = ""
                                    }
                                }
                            } label: {
                                Text("button_profile_logout".localized(language.getLanguage()))
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

                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
                .background(Color.customPrimary)
                
            }
        }.navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(LanguageViewModel())
            .environmentObject(AuthViewModel())
    }
}
