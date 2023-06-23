//
//  ContentView.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        if userID == ""{
            AuthView()
        }
        else{
            HomeView()
//            Text("Logged in!")
//            Button {
//                let firebaseAuth = Auth.auth()
//                do {
//                  try firebaseAuth.signOut()
//                    withAnimation{
//                        userID = ""
//                    }
//                } catch let signOutError as NSError {
//                  print("Error signing out: %@", signOutError)
//                }
//            } label: {
//                Text("Log Out)")
//            }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
