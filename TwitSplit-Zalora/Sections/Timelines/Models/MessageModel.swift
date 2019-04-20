//
//  MessageModel.swift
//  TwitSplit-Zalora
//
//  Created by Đăng Trình on 4/18/19.
//  Copyright © 2019 Dang Trinh. All rights reserved.
//

import UIKit

struct MessageModel {

    var username: String
    var message: String
    //var timePost: Date
    
    init(usr: String, mes: String) {
        username = usr
        message = mes
    }
    
}
