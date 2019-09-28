//
//  CachePost.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 3/2/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//


import RealmSwift

class CachePost: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    @objc dynamic var userId = 0

    override static func primaryKey() -> String? {
        return "id"
    }

    var post: Post {
        return Post(title: title, body: body, id: id)
    }
}

extension Post {
    var cachePost: CachePost {
        let post = CachePost()
        post.id = id
        post.title = title
        post.body = body
        return post
    }
}
