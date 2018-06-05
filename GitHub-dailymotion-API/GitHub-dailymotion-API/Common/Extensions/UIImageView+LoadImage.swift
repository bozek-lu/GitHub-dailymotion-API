//
//  UIImageView+LoadImage.swift
//  GitHub-dailymotion-API
//
//  Created by Łukasz Bożek on 05/06/2018.
//  Copyright © 2018 lu. All rights reserved.
//

import UIKit

extension UIImageView {
    public func loadImage(from urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let string = urlString, let url = URL(string: string) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                var image: UIImage?

                if error == nil, let unwrappedData = data {
                    image = UIImage(data: unwrappedData)
                }

                completion(image)
            }
        }.resume()
    }
}
