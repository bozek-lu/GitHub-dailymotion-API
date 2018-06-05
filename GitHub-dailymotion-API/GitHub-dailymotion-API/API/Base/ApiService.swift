//
//  ApiService.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

typealias ApiServiceSuccess = ((Any?) -> Void)
typealias ApiServiceFailure = ((Error) -> Void)

protocol ApiService {
    var success: ApiServiceSuccess? { get set }
    var failure: ApiServiceFailure? { get set }

    func start()
    func cancel()
    func restart()
}

extension ApiService {
    func restart() {
        cancel()
        start()
    }
}
