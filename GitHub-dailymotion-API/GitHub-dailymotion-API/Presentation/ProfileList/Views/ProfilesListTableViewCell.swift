//
//  ProfilesListTableViewCell.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import UIKit

class ProfilesListTableViewCell: UITableViewCell {

    // MARK: Outlets

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var indicatorView: UIActivityIndicatorView!
    @IBOutlet private var thumbnailView: UIImageView!

    // MARK: - Public methods

    func fill(with dataSource: ProfileCellDataSource) {
        titleLabel.text = dataSource.title

        indicatorView.startAnimating()

        thumbnailView.loadImage(from: dataSource.imageUrl) { [weak self] image in
            self?.thumbnailView.image = image
            self?.indicatorView.stopAnimating()
        }
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        indicatorView.stopAnimating()
        thumbnailView.image = nil
    }
}
