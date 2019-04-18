//
//  TimelinesViewController.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/18/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit

class TimelinesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
        
    }
    
    @objc func addTapped() {
        self.performSegue(withIdentifier: "showAddMessage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
