//
//  ExtensionUIImage.swift
//  GetDataPixabay
//
//  Created by Yerassyl Orazbekov on 02.12.2021.
//

import UIKit


extension UIImageView {
    func load(url: String, activityIndicator: UIActivityIndicatorView) {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        let urlFind = URL(string: url) ?? URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fdjilda2018%2F%25D0%25BE%25D1%2588%25D0%25B8%25D0%25B1%25D0%25BA%25D0%25B8%2F&psig=AOvVaw1ogv7-2IL_jkKrSX7LiqFV&ust=1638532837736000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCOi21dOIxfQCFQAAAAAdAAAAABAD")
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlFind!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}
