//
//  ChangeLanguageView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 25/06/23.
//

import SwiftUI

struct ChangeLanguageView: View {
    @EnvironmentObject var language: LanguageViewModel
    var body: some View {
        Button(action: {
            // Change the language
            language.toggleLanguage()
        }) {
            HStack{
                if(language.getLanguage().rawValue == "id"){
                    Image("indonesia-flag")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20)
                        .background(
                            Circle()
                                .stroke(lineWidth: 5)
                                .foregroundColor(Color.customDarkBackground.opacity(0.5))
                        )
                    Text("IND")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.customPrimary)
                }
                else{
                    Image("us-flag")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20)
                        .background(
                            Circle()
                                .stroke(lineWidth: 5)
                                .foregroundColor(Color.customDarkBackground.opacity(0.5))
                        )
                    Text("ENG")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.customPrimary)
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color.customButton)
                    .shadow(color: Color.customDarkBackground, radius: 3, x: 2, y: 2)
            )

        }
        .padding()
    }
}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageView()
            .environmentObject(LanguageViewModel())
    }
}
