//
//  AddPostViewProtocol.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 9/28/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import Foundation

protocol AddPostViewProtocol: class {
    func notifyDelegateWithAdded(post: Post)
    func notifyDelegateWithEdited(post: Post)    
    func dismissView()
    func loadPost(_ post: Post)
    func showSuccessMessage(title: String, message: String)
}

protocol AddPostViewControllerDelegate: class {
    func addPostViewController(_ addPostViewController: AddPostViewController, didAddPost post: Post)
    func addPostViewController(_ addPostViewController: AddPostViewController, didEditPost post: Post)
}
