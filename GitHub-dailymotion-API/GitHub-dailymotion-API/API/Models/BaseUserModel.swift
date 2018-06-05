//
//  BaseUserModel.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

protocol BaseUserModel {
    var login: String { get set }
    var avatar_url: String { get set }
}
