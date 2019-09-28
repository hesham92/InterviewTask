//
//  PostTableViewCell.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/15/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, PostCell {    
    @IBOutlet weak var postTitleLabel: UILabel!

    var postTitle: String? {
        didSet {
            postTitleLabel.text = postTitle
        }
    }
}
