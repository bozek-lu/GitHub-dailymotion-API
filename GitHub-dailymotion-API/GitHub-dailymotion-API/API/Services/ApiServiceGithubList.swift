//
//  ApiServiceGithubList.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

class ApiServiceGithubList: BaseApiService {
    override var requestUrl: String? {
        return "https://api.github.com/users"
    }

    override init() {
        super.init()
        decoder = ApiResponseJSONDecoder<Array<GithubUserModel>>()
    }
}
