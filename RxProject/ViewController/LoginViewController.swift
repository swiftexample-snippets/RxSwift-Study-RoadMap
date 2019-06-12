//
//  LoginViewController.swift
//  RxProject
//
//  Created by nxgdev58 on 12/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
extension String{
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}
class RedButton:UIButton{
    override var isEnabled: Bool{
        didSet{
            backgroundColor = isEnabled ? UIColor.red : UIColor.gray
        }
    }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var buttonLogin: RedButton!
    

    
    let loginVM = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        textEmail.rx.text.orEmpty
//            .scan("", accumulator: { (prev, next) -> String in
//                print("prev \(prev) : next \(next)")
//                print(next ~= "^[0-9]*$")
//                if (next ~= "^[0-9]*$") == false{
//                    return prev
//                }
//                return next
//            })
//            .do(onNext: { [unowned self]  in
//                self.textEmail.text = $0
//            })
            .bind(to: loginVM.emailText)
            .disposed(by: disposeBag)
        
        
        textPassword.rx.text.orEmpty
            .bind(to: loginVM.passwordText)
            .disposed(by: disposeBag)
       
        loginVM.isValid
            .bind(to: buttonLogin.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonLogin.rx.tap
            .subscribe(onNext : {
                print("tappp")
                
            })
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
