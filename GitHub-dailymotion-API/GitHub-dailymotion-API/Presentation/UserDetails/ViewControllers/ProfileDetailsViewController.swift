//
//  ProfileDetailsViewController.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import UIKit

class ProfileDetailsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var indicatorView: UIActivityIndicatorView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageIndicatorView: UIActivityIndicatorView!

    // MARK: - Private properties

    private lazy var viewModel = ProfileDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    // MARK: - Private methods

    private func loadData() {
        indicatorView.startAnimating()
        viewModel.loadData { [weak self] completion in
            self?.indicatorView.stopAnimating()

            switch completion {
            case .success:
                self?.setupView()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func setupView() {
        textLabel.attributedText = viewModel.text

        imageIndicatorView.startAnimating()
        headerImageView.loadImage(from: viewModel.imageUrl) { [weak self] image in
            self?.headerImageView.image = image
            self?.imageIndicatorView.stopAnimating()
        }

        UIView.animate(withDuration: 0.7) { [weak self] in
            self?.scrollView.alpha = 1.0
        }
    }
}

// MARK: - ProfileDetailsOwner

extension ProfileDetailsViewController: ProfileDetailsOwner {
    func setup(with profile: BaseUserModel) {
        title = profile.login

        viewModel.profile = profile
    }
}
