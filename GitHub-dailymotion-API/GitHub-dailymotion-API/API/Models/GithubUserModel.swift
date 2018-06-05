//
//  GithubUserModel.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

struct GithubUserModel: Codable, BaseUserModel {
    var login: String
    var avatar_url: String
    var identifier: Int?
    var organizations_url: String?
    var received_events_url: String?
    var following_url: String?
    var url: String?
    var node_id: String?
    var subscriptions_url: String?
    var repos_url: String?
    var type: String?
    var html_url: String?
    var events_url: String?
    var starred_url: String?
    var gists_url: String?
    var gravatar_id: String?
    var followers_url: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case login, avatar_url, identifier = "id", organizations_url, received_events_url, following_url, url, node_id, subscriptions_url, repos_url, type, html_url, events_url, starred_url, gists_url, gravatar_id, followers_url
    }
}
