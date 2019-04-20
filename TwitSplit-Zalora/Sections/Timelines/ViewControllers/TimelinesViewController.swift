//
//  TimelinesViewController.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/18/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TimelinesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    fileprivate var timelinesViewModel = TimelinesViewModel()
    fileprivate var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
        tableView.estimatedRowHeight = 400
        self.tableView.register(UINib(nibName:"PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        setupViewModel()
    }
    
    func setupViewModel() {
        //timelinesViewModel.setData()
        timelinesViewModel.postDataSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: "PostTableViewCell")) { (index, model, cell) in
            if let cell = cell as? PostTableViewCell {
                //setup cell
                cell.setData(model: model)
                print("Dang trinh test ",index)
            }
            }.disposed(by: disposeBag)
    }
    
    @objc func addTapped() {
        self.performSegue(withIdentifier: "showAddMessage", sender: nil)
        //timelinesViewModel.postDataSource.value.append(MessageModel(usr: "Dang Trinh", mes: "ADDED"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddMessage" {
            let viewController = segue.destination as! PostMessageViewController
            viewController.delegate = timelinesViewModel
        }
    }
    
}
