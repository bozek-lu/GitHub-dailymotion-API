//
//  ApiServiceDailymotionList.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

class ApiServiceDailymotionList: BaseApiService {
    override var requestUrl: String? {
        return "https://api.dailymotion.com/users?fields=avatar_360_url,username"
    }
    
    override init() {
        super.init()
        decoder = ApiResponseJSONDecoder<DailymotionResponseModel>()
    }
}
