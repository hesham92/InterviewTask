//
//  APIManager.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/15/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import Foundation

enum PostsAPI {
    case getPosts
    case addPost(post: Post)
    case editPost(post: Post)
    case deletePost(post: Post)
}

extension PostsAPI: EndpointType {
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }

    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        case .addPost(_):
            return "/posts"
        case .editPost(let post):
            return "/posts"
        case .deletePost(let post):
            return "/posts/\(post.id)"
        }
    }

    var method: HttpMethod {
        switch self {
        case .getPosts:
            return .get
        case .addPost(_):
            return .post
        case .editPost(_):
            return .post
        case .deletePost(_):
            return .delete
        }
    }

    var jsonParameters: [String: Any] {
        
        switch self {
        case .addPost(let post):
            return ["title": post.title, "body": post.body, "userId": 1]
        case .editPost(let post):
            return ["title": post.title, "body": post.body, "userId": 1, "id": post.id]
        default:
            return [:]
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
