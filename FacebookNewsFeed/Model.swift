//
//  Model.swift
//  FacebookNewsFeed
//
//  Created by Qichen Huang on 2017-12-19.
//  Copyright © 2017 Qichen Huang. All rights reserved.
//

import Foundation

struct Posts: Decodable {
    var posts: [Post]?
}

struct Post: Decodable {
    var name: String?
    var profileImageName: String?
    var statusText: String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
    var location: Location?
    var information: String?
}

struct Location: Decodable {
    var city: String?
    var state: String?
}
