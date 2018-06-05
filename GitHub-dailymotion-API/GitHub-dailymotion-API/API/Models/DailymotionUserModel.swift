//
//  DailymotionUserModel.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

struct DailymotionUserModel: Codable, BaseUserModel {
    var login: String
    var avatar_url: String
    
    private enum CodingKeys: String, CodingKey {
        case login = "username"
        case avatar_url = "avatar_360_url"
    }
}
