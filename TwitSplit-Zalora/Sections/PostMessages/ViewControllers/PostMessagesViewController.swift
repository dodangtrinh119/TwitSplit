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

protocol SplitMessageDelegate {
    func afterSplitSuccess(result: [String], username: String)
}


class PostMessageViewController: UIViewController {
    
    @IBOutlet var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet var messageTextField: UITextView!
    var viewModel = PostMessageViewModel(split: TwitSplitZalora())
    var delegate: SplitMessageDelegate!
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
                let alert = UIAlertController(title: "Split Error", message: result.errorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            else {
                self?.delegate.afterSplitSuccess(result: result.result, username: (self?.viewModel.username.value)!)
                self?.dismiss(animated: true, completion: nil)
                print(result.result)
            }
        }).disposed(by: disposeBag)
    }

    func setupView() {
        messageTextField.text = "Placeholder"
        messageTextField.textColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    
}

extension PostMessageViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}
