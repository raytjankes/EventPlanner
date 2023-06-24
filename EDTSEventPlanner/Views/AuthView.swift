//
//  AuthView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login" //login or register
    var body: some View {
        if (currentViewShowing == "login"){
            LoginView(currentViewShowing: $currentViewShowing)
                .transition(.opacity)
        } else{
            RegisterView(currentViewShowing: $currentViewShowing)
                .transition(.move(edge: .bottom))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(LanguageViewModel())
    }
}
