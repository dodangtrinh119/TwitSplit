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

class TimelinesViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    fileprivate var timelinesViewModel = TimelinesViewModel()
    fileprivate var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupViewModel()
    }
    
    fileprivate func setupViewModel() {
        timelinesViewModel.postDataSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: "PostTableViewCell")) { (index, model, cell) in
            if let cell = cell as? PostTableViewCell {
                //setup cell
                cell.setData(model: model)
            }
            }.disposed(by: disposeBag)
    }
    
    fileprivate func setupView() {
        navigationItem.title = "Twit Split"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Post", style: .done, target: self, action: #selector(addTapped))
        
        self.tableView.register(UINib(nibName:"PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func addTapped() {
        self.performSegue(withIdentifier: "showAddMessage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddMessage" {
            let viewController = segue.destination as! PostMessageViewController
            viewController.delegate = timelinesViewModel
        }
    }
    
}
