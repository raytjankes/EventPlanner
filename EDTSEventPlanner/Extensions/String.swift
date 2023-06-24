//
//  String.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import Foundation

extension String{
    
    // Check if String is actually email
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
       }
    
    
    // Checking password to be 6 characters long and with a number
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
    
    // Localizes a string using given language from Language enum.
    func localized(_ language: Language) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return localized(bundle: bundle)
    }

    // Localizes a string using given language from Language enum.
    func localized(_ language: Language, args arguments: CVarArg...) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return String(format: localized(bundle: bundle), arguments: arguments)
    }

    // Localizes a string using self as key.
    private func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
