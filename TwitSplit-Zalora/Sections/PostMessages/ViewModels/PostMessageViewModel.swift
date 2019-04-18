//
//  PostMessageViewModel.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/18/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PostMessageViewModel {
    
    private let disposeBag = DisposeBag()
    var username = Variable<String>("")
    var message = Variable<String>("")
    let isValid: Observable<Bool>
    private var splitter: TwitSplitStrategy
    
    init(split: TwitSplitStrategy) {
        isValid = Observable.combineLatest(self.username.asObservable(), self.message.asObservable())
        { (username, message) in
            return username.count > 0 && message.count > 0
        }
        splitter = split
    }
    
    func confirmButtonValid(username: Observable<String>, password: Observable<String>) -> Observable<Bool> {
        return Observable.combineLatest(username, password) { (username, password) in
            return username.count > 0 && password.count > 0
        }
    }
    
    func splitMessage() {
        let splitResult = splitter.splitMessage(message: message.value, limit: LIMIT_CHAR_IN_WORD)
        //split has error
        if splitResult.errorMessage != nil {
            let alert = UIAlertController(title: "Slit error", message: splitResult.errorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    
}

