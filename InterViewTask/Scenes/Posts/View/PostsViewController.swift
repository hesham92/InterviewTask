//
//  PostsViewController.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/15/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, LoadingViewShowing, ErrorViewShowing {
   @IBOutlet private weak var postsTableView: UITableView!

    var presenter: PostsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter.viewDidLoad()
    }
    
    func setupView() {
        self.title = R.string.localizable.posts()
    }

    class func navigationController() -> UINavigationController {
        return R.storyboard.posts.instantiateInitialViewController()!
    }
    
    @IBAction func addPostAction(_ sender: UIBarButtonItem) {
        presenter.didTapAddPost()
    }
}

extension PostsViewController: UITextViewDelegate {
    
}
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.postsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.postTableViewCell, for: indexPath)!
        cell.accessibilityIdentifier = "MyCell_\(indexPath.row)"
        presenter.configureCell(cell, atIndexPath: indexPath)

        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectPostAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: R.string.localizable.delete()) {[weak self] (action, indexPath) in
            self?.presenter.deletePost(at: indexPath)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: R.string.localizable.edit()) {[weak self] (action, indexPath) in
            self?.presenter.editPost(at: indexPath)
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
}

extension PostsViewController: PostsViewProtocol {
    func reloadPost(at indexPath: IndexPath) {
        self.postsTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func addPost(at indexPath: IndexPath) {
        self.postsTableView.beginUpdates()
        self.postsTableView.insertRows(at: [indexPath], with: .automatic)
        self.postsTableView.endUpdates()
    }
    
    func removePost(at indexPath: IndexPath) {
        self.postsTableView.beginUpdates()
        self.postsTableView.deleteRows(at: [indexPath], with: .automatic)
        self.postsTableView.endUpdates()
    }
    
    func showPosts() {
        self.postsTableView.reloadData()
    }
}

extension PostsViewController: AddPostViewControllerDelegate {
    func addPostViewController(_ addPostViewController: AddPostViewController, didEditPost post: Post) {
        self.presenter.editPost(post)
    }
    
    func addPostViewController(_ addPostViewController: AddPostViewController, didAddPost post: Post) {
        self.presenter.addPost(post)
    }
}
