//
//  RealmCache.swift
//  InterViewTask
//
//  Created by Hesham Mohamed on 3/2/19.
//  Copyright © 2019 Hesham Mohamed. All rights reserved.
//


import Foundation
import RealmSwift

class RealmCache: Cache {

    private var realm: Realm { return realmFactory() }
    private let realmFactory: () -> Realm

    init(realmFactory: @escaping () -> Realm = { try! Realm() } ) {
        self.realmFactory = realmFactory
    }

    var posts: [Post] {
        get {
            return realm.objects(CachePost.self).map({ $0.post })
        }

        set {
            try? realm.write {
                realm.add(newValue.map({ $0.cachePost }), update: true)
            }
        }
    }
}
