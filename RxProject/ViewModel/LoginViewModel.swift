//
//  LoginViewModel.swift
//  RxProject
//
//  Created by nxgdev58 on 12/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    
    var emailText  = BehaviorSubject<String>(value: "")
    var passwordText = BehaviorSubject<String>(value: "")
    
    var isValidEmail : Observable<Bool> {
        return self.emailText.asObservable().map { username in
            username.count >= 6
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
