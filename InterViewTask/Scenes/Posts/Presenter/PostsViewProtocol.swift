//
//  PostsViewProtocol.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/15/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import UIKit

protocol PostsViewProtocol: class {
    func showPosts()
    func removePost(at indexPath: IndexPath)
    func addPost(at indexPath: IndexPath)
    func reloadPost(at indexPath: IndexPath)
}

protocol PostCell: class {
    var postTitle: String? { get set }
}
