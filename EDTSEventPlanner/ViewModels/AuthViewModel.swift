//
//  AuthViewModel.swift
//  EDTSEventPlanner
//
//  Created by Ray on 24/06/23.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    
    func getCurrentUserEmail() -> String?{
        return Auth.auth().currentUser?.email
    }
    
    func registerEmailPassword(email: String, password: String, completion: @escaping (String) -> Void) {
        var resultUID = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                completion("")
            }
            if let authResult = authResult {
                let userID = String(authResult.user.uid)
                print(userID)
                completion(userID)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                completion("")
            }
            
            if let authResult = authResult {
                let userID = String(authResult.user.uid)
                print(userID)
                completion(userID)
            }
        }
    }

    

    func logout (completion: @escaping (String) -> Void) {
        var result = "Failure"
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            result = "Success"
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        completion(result)
        
    }
}
