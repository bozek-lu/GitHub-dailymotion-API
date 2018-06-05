//
//  ApiError.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

struct ApiErrorsFactory {
    private static var domain: String {
        return "test.error"
    }

    enum Code: Int {
        case invalidResponse = 1000
        case invalidDecodedData
        case missingParameters
    }

    static func makeError(for code: ApiErrorsFactory.Code) -> Error {
        return NSError(domain: domain, code: code.rawValue, userInfo: nil)
    }
}
