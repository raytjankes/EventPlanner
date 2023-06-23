//
//  String.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import Foundation

extension String{
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
       }
    
    
    // 6 characters long and with a number
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
    
}
