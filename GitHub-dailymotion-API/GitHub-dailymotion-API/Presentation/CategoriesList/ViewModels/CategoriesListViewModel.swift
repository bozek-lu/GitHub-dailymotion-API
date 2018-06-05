//
//  CategoriesListViewModel.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

enum Categories: String {
    case github = "GitHub"
    case dailymotion = "DailyMotion"
    case merged = "Merged"
}

class CategoriesListViewModel {

    enum Completion {
        case success
        case failure(Error)
    }

    // MARK: - Public properties
    lazy var githubService: ApiService = {
        return ApiServiceGithubList()
    }()

    lazy var dailymotionService: ApiService = {
        return ApiServiceDailymotionList()
    }()

    var categoriesCount: Int {
        return categories.count
    }
    // MARK: - Private properties

    private var documentsPerCategory = [String: [BaseUserModel]]()
    
    private var categories = [Categories.merged.rawValue, Categories.github.rawValue, Categories.dailymotion.rawValue]

    // MARK: - Public methods

    func category(for indexPath: IndexPath) -> String {
        return categories[indexPath.row]
    }

    func profiles(for indexPath: IndexPath) -> [BaseUserModel]? {
        return documentsPerCategory[category(for: indexPath)]
    }

    func loadData(with completion: @escaping (Completion) -> Void) {
        var merged = [BaseUserModel]()
        self.documentsPerCategory[Categories.merged.rawValue] = merged
        
        githubService.cancel()
        githubService.success = { [weak self] data in
            if let githubList = data as? [BaseUserModel] {
                self?.documentsPerCategory[Categories.github.rawValue] = githubList
                merged += githubList
                self?.documentsPerCategory[Categories.merged.rawValue] = merged
                completion(.success)
            } else {
                let error = ApiErrorsFactory.makeError(for: .invalidDecodedData)
                completion(.failure(error))
            }
        }

        githubService.failure = { error in
            completion(.failure(error))
        }

        githubService.start()
        
        dailymotionService.cancel()
        dailymotionService.success = { [weak self] data in
            if let dailymotion = data as? DailymotionResponseModel {
                self?.documentsPerCategory[Categories.dailymotion.rawValue] = dailymotion.list
                merged += dailymotion.list as [BaseUserModel]
                self?.documentsPerCategory[Categories.merged.rawValue] = merged
                completion(.success)
            } else {
                let error = ApiErrorsFactory.makeError(for: .invalidDecodedData)
                completion(.failure(error))
            }
        }
        
        dailymotionService.failure = { error in
            completion(.failure(error))
        }
        
        dailymotionService.start()
        
        
    }
    
    
}
