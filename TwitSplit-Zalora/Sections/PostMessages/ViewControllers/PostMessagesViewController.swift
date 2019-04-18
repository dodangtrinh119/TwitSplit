//
//  PostMessagesViewController.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/18/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import RxSwift
import RxCocoa

class PostMessageViewController: UIViewController {
    
    @IBOutlet var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet var messageTextField: UITextView!
    var viewModel = PostMessageViewModel(split: TwitSplitZalora())
    fileprivate var disposeBag = DisposeBag()
    private var doneButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    
    func setupViewModel() {
        usernameTextField.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
        messageTextField.rx.text.orEmpty.bind(to: viewModel.message).disposed(by: disposeBag)
        viewModel.isValid.map { $0 }
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
        doneButton.rx.tap.bind {
            self.viewModel.splitMessage()
        }.disposed(by: disposeBag)
        viewModel.splitResult.subscribe(onNext: { [weak self] (result) in
            if result.errorMessage != nil {
                //display error
            }
            else {
                //return values
                print(result.result)
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    func setupView() {
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    
}
