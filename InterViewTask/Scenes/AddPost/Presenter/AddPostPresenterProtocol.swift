//
//  AddPostPresenterProtocol.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 9/28/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import Foundation

protocol AddPostPresenterProtocol: class {
    func savePost(with title: String, and body: String)
    func viewDidLoad()
}
