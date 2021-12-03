//
//  ShowDetailPhotoViewController.swift
//  GetDataPixabay
//
//  Created by Yerassyl Orazbekov on 30.11.2021.
//

import UIKit

class ShowDetailPhotoViewController: UIViewController {

    @IBOutlet weak var downloads: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloads.text = "Downloads:"
        views.text = "Views:"
        likes.text = "Likes:"
        
    }
}
