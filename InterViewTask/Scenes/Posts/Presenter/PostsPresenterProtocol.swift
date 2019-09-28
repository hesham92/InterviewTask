//
//  PostsPresenterProtocol.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/28/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import UIKit

protocol PostsPresenterProtocol: class {
    var postsCount: Int { get }
    func viewDidLoad()
    func didTapAddPost()
    func addPost(_ post: Post)
    func editPost(_ post: Post)
    func editPost(at indexPath: IndexPath)
    func deletePost(at indexPath: IndexPath)
    func configureCell(_ cell: PostCell, atIndexPath indexPath: IndexPath)
    func didSelectPostAtIndexPath(_ indexPath: IndexPath)
}
