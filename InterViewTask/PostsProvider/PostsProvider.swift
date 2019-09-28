//
//  PostsProvider.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 12/28/18.
//  Copyright © 2018 Hesham Mohamed. All rights reserved.
//

import Foundation

protocol PostsProviderProtocol {
  //  var cache: ReadOnlyCache { get }
    func getPosts(completion: @escaping (Result<[Post]>) -> ())
    func addPost(_ post: Post, completion: @escaping (Result<Post>) -> ())
    func deletePost(_ post: Post, completion: @escaping (Result<DeletePostResponse>) -> ())
    func editPost(_ post: Post, completion: @escaping (Result<Post>) -> ())
}

enum PostsProviderError: Error {
    case emptyUserResult
}

class PostsProvider: PostsProviderProtocol {
    private let completionQueue: DispatchQueue
   // private var _cache: Cache
    private let api: HttpService<PostsAPI>

    init(completionQueue: DispatchQueue = .main/*, cache: Cache = RealmCache()*/, api: HttpService<PostsAPI> = HttpService<PostsAPI>()) {
        self.completionQueue = completionQueue
       // self._cache = cache
        self.api = api
    }

   /* var cache: ReadOnlyCache {
        return _cache
    }
 */

    func getPosts(completion: @escaping (Result<[Post]>) -> ()) {
        api.request(.getPosts, modelType: [Post].self) { result in
            self.completionQueue.async {
                completion(result)
            }

            // cache Posts
            if case let Result.success(posts) = result {
              //  self._cache.posts = posts
            }
        }
    }
    
    func addPost(_ post: Post, completion: @escaping (Result<Post>) -> ()) {
        api.request(PostsAPI.addPost(post: post), modelType: Post.self) { result in
            self.completionQueue.async {
                completion(result)
            }
        }
    }
    
    func deletePost(_ post: Post, completion: @escaping (Result<DeletePostResponse>) -> ()) {
        api.request(.deletePost(post: post), modelType: DeletePostResponse.self) { result in
            self.completionQueue.async {
                completion(result)
            }
        }
    }
    
    func editPost(_ post: Post, completion: @escaping (Result<Post>) -> ()) {
        api.request(.editPost(post: post), modelType: Post.self) { result in
            self.completionQueue.async {
                completion(result)
            }
        }
    }
    
    
}
