//
//  Post.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/15/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//



typealias DeletePostResponse = [String : Int]

struct AddPostResponse: Codable {
    let id: Int
}

struct EditPostResponse: Codable {
    let id: Int
}

struct Post: Codable, Equatable {
    let title: String
    let id: Int
    let body: String
    
    init(title: String, body: String, id: Int = 0) {
        self.title = title
        self.body = body
        self.id = id
    }
}
