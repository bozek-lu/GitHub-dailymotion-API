//
//  ProfileDetailsViewModel.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import Foundation
import UIKit

class ProfileDetailsViewModel {

    enum Completion {
        case success()
        case failure(Error)
    }

    // MARK: - Public properties

    lazy var serviceBuilder: (BaseUserModel) -> BaseUserModel = { profile in
        return profile
    }

    var profile: BaseUserModel?

    // MARK: - Computed properties

    var imageUrl: String? {
        return profileDetails?.avatar_url
    }

    var text: NSAttributedString? {
        let text = NSMutableAttributedString(string:  ((profileDetails as? GithubUserModel) != nil) ? "GitHub" : "Dailymotion")
        text.addAttributes([.font: UIFont.db_default(), .foregroundColor: UIColor.db_red()],
                            range: NSRange(location: 0, length: text.length))

        return text
    }

    // MARK: - Private properties

    private var service: ApiService?
    private var profileDetails: BaseUserModel?

    // MARK: - Public methods

    func loadData(with completion: @escaping (Completion) -> Void) {
        guard let profile = profile else {
            completion(.failure(ApiErrorsFactory.makeError(for: .missingParameters)))
            return
        }

//        service = serviceBuilder(documentId)
//        service?.success = { [weak self] data in
//            if let documentDetails = data as? DocumentDetailsModel {
                self.profileDetails = profile
                completion(.success())
//            } else {
//                let error = ApiErrorsFactory.makeError(for: .invalidDecodedData)
//                completion(.failure(error))
//            }
//        }
//
//        service?.failure = { error in
//            completion(.failure(error))
//        }

        service?.start()
    }
}
