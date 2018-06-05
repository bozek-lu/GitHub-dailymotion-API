//
//  GitHub_dailymotion_APITests.swift
//  GitHub-dailymotion-APITests
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import XCTest
@testable import GitHub_dailymotion_API


private extension GithubUserModel {
    init(_ identifier: Int) {
        self.init(login: "\(identifier)", avatar_url: "", identifier: nil, organizations_url: "", received_events_url: "", following_url: "" , url: "" , node_id: "", subscriptions_url: "",
                  repos_url: "", type: "", html_url: "",
                  events_url: "", starred_url: "", gists_url: "", gravatar_id: "", followers_url: "")
    }
}

private extension DailymotionUserModel {
    init(_ identifier: Int) {
        self.init(login: "\(identifier)", avatar_url: "")
    }
}


class CategoriesListViewModelTests: XCTestCase {
    
    func testLoadDataWithNilData() {
        let sut = CategoriesListViewModel()
        sut.githubService = ApiServiceStub(.success(nil))
        sut.dailymotionService = ApiServiceStub(.success(nil))
        
        var successCalled = false
        var failureCalled = false
        var returnedError: Error?
        
        sut.loadData { completion in
            switch completion {
            case .success:
                successCalled = true
            case .failure(let error):
                returnedError = error
                failureCalled = true
            }
        }
        
        XCTAssertNotNil(returnedError)
        XCTAssertFalse(successCalled)
        XCTAssertTrue(failureCalled)
    }
    
    func testLoadDataWithIncorrectData() {
        let sut = CategoriesListViewModel()
        let fakeObject = Date()
        sut.githubService = ApiServiceStub(.success(fakeObject))
        sut.dailymotionService = ApiServiceStub(.success(fakeObject))
        
        var successCalled = false
        var failureCalled = false
        var returnedError: Error?
        
        sut.loadData { completion in
            switch completion {
            case .success:
                successCalled = true
            case .failure(let error):
                returnedError = error
                failureCalled = true
            }
        }
        
        XCTAssertNotNil(returnedError)
        XCTAssertFalse(successCalled)
        XCTAssertTrue(failureCalled)
    }
    
    func testLoadDataWithCorrectData() {
        let sut = CategoriesListViewModel()
        let gitUs = [GithubUserModel(1), GithubUserModel(2), GithubUserModel(3)]
        let dailUs = [DailymotionUserModel(4), DailymotionUserModel(5), DailymotionUserModel(6)]
        sut.githubService = ApiServiceStub(.success(gitUs))
        sut.dailymotionService = ApiServiceStub(.success(DailymotionResponseModel(list: dailUs)))
        
        var successCalled = false
        var failureCalled = false
        var returnedError: Error?
        
        sut.loadData { completion in
            switch completion {
            case .success:
                successCalled = true
            case .failure(let error):
                returnedError = error
                failureCalled = true
            }
        }
        
        XCTAssertNil(returnedError)
        XCTAssertTrue(successCalled)
        XCTAssertFalse(failureCalled)
        XCTAssertEqual(sut.categoriesCount, 3)
    }
    
    func testLoadDataFailed() {
        let sut = CategoriesListViewModel()
        sut.githubService = ApiServiceStub(.failure(ApiErrorsFactory.makeError(for: .invalidResponse)))
        
        var successCalled = false
        var failureCalled = false
        var returnedError: Error?
        
        sut.loadData { completion in
            switch completion {
            case .success:
                successCalled = true
            case .failure(let error):
                returnedError = error
                failureCalled = true
            }
        }
        
        XCTAssertNotNil(returnedError)
        XCTAssertFalse(successCalled)
        XCTAssertTrue(failureCalled)
    }
}
