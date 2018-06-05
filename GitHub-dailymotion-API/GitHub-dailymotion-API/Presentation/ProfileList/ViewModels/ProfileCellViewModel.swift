//
//  ProfileCellViewModel.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

protocol ProfileCellDataSource {
    var title: String { get }
    var imageUrl: String { get }
}

struct ProfileCellViewModel: ProfileCellDataSource {
    var title: String
    var imageUrl: String

    init(profile: BaseUserModel) {
        title = profile.login
        imageUrl = profile.avatar_url
    }
}
