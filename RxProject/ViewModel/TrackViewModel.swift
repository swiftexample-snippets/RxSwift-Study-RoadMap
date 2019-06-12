//
//  TracksViewModel.swift
//  RxProject
//
//  Created by nxgdev58 on 10/6/19.
//  Copyright © 2019 nxgdev58. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class TracksViewModel {
    public let onTracksUpdate : PublishSubject<[Track]> = PublishSubject()
    public enum ApiError{
        case internetError(String)
        case serverMessage(String)
    }
    
   
    public let error : PublishSubject<ApiError> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    var contacts : [Track] = []
    func setupSearch(text: RxCocoa.ControlProperty<String?>){
        text
         
            .orEmpty
            .skip(1)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .flatMapLatest{[unowned self] in self.searchBy(text: $0)}
            .bind(to: self.onTracksUpdate) // Binding Direct to publish subject
            
            //            .subscribe(onNext:{ [unowned self] filteredContacts  in
            //                self.trackVM.onTracksUpdate.onNext(filteredContacts)
            //            }) // Binding to a different publish subject tableview
            .disposed(by: disposeBag)
    }
    
    func searchBy(text:String?) -> Observable<[Track]>{
        return  Observable.deferred{ [unowned self] in
            guard let text = text?.lowercased(), text.isEmpty == false else{
                return .just(self.contacts)
            }
            return .just(self.contacts.filter{$0.trackName.lowercased().contains(text) == true})
        }
    }
    
    public func loadData(){
        Track.allTracks()
        .do(onNext: { (data) in
            self.contacts.removeAll()
            self.contacts.append(contentsOf: data)
            self.onTracksUpdate.onNext(data)
        })
        .subscribe()
        .disposed(by: disposeBag)
    }
    
}


//struct BIPTRecurringBodyModel: Codable{
//    let recurringInformation: [Result]?
//    var recurringInformationSorted: [Result]{
//        return recurringInformation?.sorted(by: { (info1, info2) -> Bool in
//            return UIContentSizeCategory(rawValue: (info1.trackName!)) > UIContentSizeCategory(rawValue: (info2.trackName!))
//        }) ?? []
//    }
//
//}


struct LoginViewModel {
    
    var emailText  = BehaviorSubject<String>(value: "")
    var passwordText = BehaviorSubject<String>(value: "")
    
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


