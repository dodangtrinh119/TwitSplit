//
//  PostTableViewCell.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/18/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userAvatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(model: MessageModel) {
        usernameLabel.text = model.username
        messageLabel.text = model.message
    }
    
}
