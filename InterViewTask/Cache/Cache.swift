//
//  Cache.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 3/2/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//

import Foundation

protocol ReadOnlyCache {
    var posts: [Post] { get }
}


protocol Cache: ReadOnlyCache {
    var posts: [Post] { get set }
}
