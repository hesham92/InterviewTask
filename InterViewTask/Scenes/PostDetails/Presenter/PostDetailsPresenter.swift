//
//  PostDetailsPresenter.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 3/2/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import UIKit

class PostDetailsPresenter: PostDetailsPresenterProtocol {
    private weak var view: PostDetailsViewProtocol?
    private(set) var post: Post
   
    init(post: Post, view: PostDetailsViewProtocol) {
        self.view = view
        self.post = post
    }

    func viewDidLoad() {
        // show post
     //   self.getPostDetails()
    }
}
