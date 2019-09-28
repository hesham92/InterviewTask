//
//  PostDetailsViewController.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 3/2/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController, ErrorViewShowing, LoadingViewShowing {
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!

    var presenter: PostDetailsPresenter!

    class func newController() -> PostDetailsViewController {
        return R.storyboard.postDetails.postDetailsViewController()!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension PostDetailsViewController: PostDetailsViewProtocol {
    func showPostDetails(title: String, body: String) {
        self.postTitleLabel.text = title
        self.postBodyLabel.text = body
    }
}
