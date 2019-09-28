//
//  Navigator.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/17/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import UIKit

protocol Navigator: class {
    associatedtype Destination

    func navigate(to destination: Destination)
}

class AppNavigator: Navigator {
    private weak var window: UIWindow?
    private var navigationController: UINavigationController?
    private var postsViewController: PostsViewController!
    static let shared = AppNavigator()

    enum Destination {
        case postDetails(post: Post)
        case addPost
        case editPost(post: Post)
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .postDetails(let post):
            let postDetailsViewController = PostDetailsViewController.newController()
            let postDetailsPresenter = PostDetailsPresenter(post: post, view: postDetailsViewController)
            postDetailsViewController.presenter = postDetailsPresenter
            navigationController?.pushViewController(postDetailsViewController, animated: true)
        case .addPost:
            let addPostViewController = AddPostViewController.newController()
            let addPostPresenter = AddPostPresenter(view: addPostViewController)
            addPostViewController.presenter = addPostPresenter
            addPostViewController.addPostViewControllerDelegate = postsViewController
            addPostViewController.modalPresentationStyle = .overCurrentContext
            navigationController?.present(addPostViewController, animated: true, completion: nil)
        case .editPost(let post):
            let addPostViewController = AddPostViewController.newController()
            let addPostPresenter = AddPostPresenter(view: addPostViewController)
            addPostViewController.presenter = addPostPresenter
            addPostViewController.addPostViewControllerDelegate = postsViewController
            addPostPresenter.post = post
            addPostViewController.modalPresentationStyle = .overCurrentContext
            navigationController?.present(addPostViewController, animated: true, completion: nil)
        }
    }

    func start(window: inout UIWindow?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = PostsViewController.navigationController()
        postsViewController = navigationController?.topViewController as? PostsViewController
        postsViewController.presenter = PostsPresenter(view: postsViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        self.window = window
    }
}
