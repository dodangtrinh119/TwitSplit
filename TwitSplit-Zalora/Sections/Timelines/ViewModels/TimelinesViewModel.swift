//
//  TimelinesViewModel.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/18/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TimelinesViewModel: SplitMessageDelegate {
    
    private let disposeBag = DisposeBag()
    fileprivate(set) var postDataSource = Variable([MessageModel]())
    fileprivate(set) var isLoadingAnimation = PublishSubject<Bool>()

    func setData() {
//        for i in 0...5 {
//            var temp = MessageModel(usr: (i+10).description, mes: "AVXSD" + (i).description)
//            postDataSource.value.append(temp)
//        }
    }
    
    func afterSplitSuccess(result: [String], username: String) {
        var newData = [MessageModel]()
        for mess in result {
            let newPost = MessageModel(usr: username, mes: mess)
            newData.append(newPost)
        }
        postDataSource.value.append(contentsOf: newData)
    }
}
