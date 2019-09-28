//
//  PostsPresenter.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/15/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import UIKit

class PostsPresenter: PostsPresenterProtocol {
    
    typealias PostsView = PostsViewProtocol & LoadingViewShowing & ErrorViewShowing
    private weak var view: PostsView?
    private weak var navigator: AppNavigator!
    private var postsProvider: PostsProviderProtocol
    private(set) var posts: [Post] = []
    private var networkError: NetworkError? = nil
    private var notificationCenter: NotificationCenter

    init(view: PostsView, navigator: AppNavigator = .shared, postsProvider: PostsProviderProtocol = PostsProvider(), notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.view = view
        self.navigator = navigator
        self.postsProvider = postsProvider
        self.notificationCenter = notificationCenter
        self.addInternetObservers()
    }

    var postsCount: Int {
        return posts.count
    }

    func viewDidLoad() {
        self.getPosts()
    }

    private func getPosts() {
        self.view?.showLoading()
        self.postsProvider.getPosts { [weak self] (result) in
            guard let self = self else { return }
            self.view?.hideLoading()

            switch(result) {
            case .success(let posts):
                self.posts = posts
                self.view?.showPosts()
            case .failure(let error):
                self.view?.showError(error)

                if let error = NetworkError(error: error), error == .noInternet {
                    self.networkError = error
                //    self.posts = self.postsProvider.cache.posts
                    if self.posts.count > 0 {
                        self.view?.showPosts()
                    }
                }
            }
        }
    }
    
    
    func editPost(at indexPath: IndexPath) {
        navigator.navigate(to: .editPost(post: posts[indexPath.row]))
    }
    
    func didTapAddPost() {
        navigator.navigate(to: .addPost)
    }
    
    func deletePost(at indexPath: IndexPath) {
        let deletedPost = posts[indexPath.row]
        self.posts = self.posts.filter({$0.id != deletedPost.id})
        self.view?.showLoading()
        self.postsProvider.deletePost(deletedPost) {  [weak self] (result) in
            guard let self = self else { return }
            self.view?.hideLoading()
            switch(result) {
            case .success(_):
                self.view?.removePost(at: indexPath)
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
    
    func addPost(_ post: Post) {
        self.posts.insert(post, at: 0)
        self.view?.addPost(at: IndexPath(row: 0, section: 0))
    }
    
    func editPost(_ post: Post) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        posts[index] = post
        self.view?.reloadPost(at: IndexPath(row: index, section: 0))
    }
    
    func configureCell(_ cell: PostCell, atIndexPath indexPath: IndexPath) {
        let post = posts[indexPath.row]
        cell.postTitle = post.title
    }

    func didSelectPostAtIndexPath(_ indexPath: IndexPath) {
        let post = posts[indexPath.row]
        navigator.navigate(to: .postDetails(post: post))
    }

   
    
    private func addInternetObservers() {
        notificationCenter.addObserver(self,selector: #selector(self.handleInternetStatus),name: .InternetStatus, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .InternetStatus, object: nil)
    }

    @objc private func handleInternetStatus(notification: NSNotification){
        if let online = notification.userInfo?[InternetConnection.Keys.InternetStatus] as? Bool {
            if online {
                if networkError != nil {
                    self.networkError = nil
                    self.getPosts()
                }
            }
        }
    }
}
