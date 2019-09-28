//
//  AddPostPresenter.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 9/28/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import UIKit

class AddPostPresenter: AddPostPresenterProtocol {
    typealias addPostView = AddPostViewProtocol & LoadingViewShowing & ErrorViewShowing
    private weak var view: addPostView?
    private var postsProvider: PostsProviderProtocol
    var post: Post?
    
    init(view: addPostView, postsProvider: PostsProviderProtocol = PostsProvider()) {
        self.view = view
        self.postsProvider = postsProvider
    }
    
    func savePost(with title: String, and body: String) {
        let newPost = Post(title: title, body: body, id: post?.id ?? 0)
        if let _ = post {
            self.editPost(newPost)
        } else {
            self.addPost(newPost)
        }
    }
    
    func addPost(_ addedPost: Post) {
        self.view?.showLoading()
        self.postsProvider.addPost(addedPost) {  [weak self] (result) in
            guard let self = self else { return }
            self.view?.hideLoading()
            switch(result) {
            case .success(_):
                self.view?.notifyDelegateWithAdded(post: addedPost)
                self.view?.showSuccessMessage(message: "Post added succssfully")
                self.view?.dismissView()
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
    
    func editPost(_ editedPost: Post ) {
        self.view?.showLoading()
        self.postsProvider.editPost(editedPost) {  [weak self] (result) in
            guard let self = self else { return }
            self.view?.hideLoading()
            switch(result) {
            case .success(_):
                self.view?.notifyDelegateWithEdited(post: editedPost)
                self.view?.showSuccessMessage(message: "Post edited succssfully")
                self.view?.dismissView()
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
    
    func viewDidLoad() {
        if let post = post {
            self.view?.loadPost(post)
        }
    }
}
