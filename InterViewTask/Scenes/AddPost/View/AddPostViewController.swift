//
//  AddPostViewController.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 9/28/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class AddPostViewController: UIViewController, LoadingViewShowing & ErrorViewShowing {
    
    @IBOutlet weak var dimmedView: UIView!
    @IBOutlet private weak var postTitleTextField: UITextField!
    @IBOutlet private weak var bodyTextView: UITextView!
     var presenter: AddPostPresenter!
    weak var addPostViewControllerDelegate: AddPostViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.viewDidLoad()
    }
    
    class func newController() -> AddPostViewController {
        return R.storyboard.addPost.addPostViewController()!
    }
    
    func setupViews() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.dismissView))
        self.dimmedView.addGestureRecognizer(gesture)
        
        self.postTitleTextField.layer.borderWidth = 1.0
        self.postTitleTextField.layer.borderColor = UIColor.init(red: 220.0 / 255.0, green: 220.0 / 255.0, blue: 2220.0 / 255.0, alpha: 1.0).cgColor
        self.bodyTextView.layer.borderWidth = 1.0
        self.bodyTextView.layer.borderColor = UIColor.init(red: 220.0 / 255.0, green: 220.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0).cgColor
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
    }
    
}

extension AddPostViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            
            guard let postTitle = postTitleTextField.text, let postBody = bodyTextView.text else {
                return false
            }
            
            presenter.savePost(with: postTitle, and: postBody)
        }
        return true
    }
}

extension AddPostViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            bodyTextView.becomeFirstResponder()
        }
        return true
    }
}

extension AddPostViewController: AddPostViewProtocol {
    func notifyDelegateWithAdded(post: Post) {
        self.addPostViewControllerDelegate?.addPostViewController(self, didAddPost: post)
    }
    
    func notifyDelegateWithEdited(post: Post) {
        self.addPostViewControllerDelegate?.addPostViewController(self, didEditPost: post)
    }
    
    func loadPost(_ post: Post) {
        self.bodyTextView.text = post.body
        self.postTitleTextField.text = post.title
    }
    
   @objc func dismissView() {
        self.dismiss(animated: true)
    }
    
    func showSuccessMessage(message: String) {
        let banner = NotificationBanner(title: "Success", subtitle: message, style: .success)
        banner.show()
    }
}
