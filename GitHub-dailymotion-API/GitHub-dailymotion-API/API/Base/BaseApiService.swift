//
//  BaseApiService.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation

enum ApiServiceMethod: String {
    case GET
    case POST
}

class BaseApiService: ApiService {

    // MARK: - Public properties

    var success: ApiServiceSuccess?
    var failure: ApiServiceFailure?
    var method = ApiServiceMethod.GET
    lazy var decoder: ApiResponseDecoder = ApiResponseDefaultDecoder()

    var requestUrl: String? {
        return ""
    }

    // MARK: - Private properties

    private var task: URLSessionTask?
    private lazy var session = URLSession.shared

    // MARK: - Public methods

    func start() {
        guard let urlRequest = request() else {
            return
        }

        task = session.dataTask(with: urlRequest) { [weak self] (data, _, error) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }

                if let error = error {
                    strongSelf.failure?(error)
                } else if let decodedData = strongSelf.decoder.decode(data) {
                    strongSelf.success?(decodedData)
                } else {
                    strongSelf.failure?(ApiErrorsFactory.makeError(for: .invalidResponse))
                }
            }

        }

        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }

    // MARK: - Private methods

    private func request() -> URLRequest? {
        guard let urlString = requestUrl, let url = URL(string: urlString) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}
