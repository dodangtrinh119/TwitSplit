//
//  ViewController.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/17/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))

    }
    
    @objc func addTapped() {
        self.performSegue(withIdentifier: "showAddMessage", sender: nil)
    }


}

