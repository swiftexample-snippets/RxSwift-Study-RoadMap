//
//  LoginVM.swift
//  RxProject
//
//  Created by nxgdev58 on 26/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginVM {
    
    var emailText  = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    
    var isValidEmail : Observable<Bool> {
        
        return self.emailText.asObservable().map { email in
            
            Validator.validEmail(email: email)
        }
    }
    
    var isValidPassword: Observable<Bool> {
        return self.passwordText.asObservable().map{ password in
            password.count >= 6
            
        }
    }
    
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(isValidEmail, isValidPassword){
            $0 && $1
        }
    }
    
}

class Validator {
    
    class func validEmail(email:String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^\\S+@\\S+\\.\\S+$", options: .caseInsensitive){
            return regex.matches(in: email, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0,                                                                                                                        email.lengthOfBytes(using: String.Encoding.utf8))).count > 0 }
        return false
    }
}
