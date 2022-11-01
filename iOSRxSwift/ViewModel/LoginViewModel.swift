//
//  LoginViewModel.swift
//  iOSRxSwift
//
//  Created by Nuntapat Hirunnattee on 1/11/2565 BE.
//

import Foundation
import RxSwift

class LoginViewModel{
    let usernameTextPubilshSubject = PublishSubject<String>()
    let passwordTextPubilshSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool>{
        Observable.combineLatest(usernameTextPubilshSubject.asObserver().startWith(""), passwordTextPubilshSubject.asObserver().startWith("")).map { username, password in
            return username.count > 3 && password.count > 3
        }.startWith(false)
    }
}
