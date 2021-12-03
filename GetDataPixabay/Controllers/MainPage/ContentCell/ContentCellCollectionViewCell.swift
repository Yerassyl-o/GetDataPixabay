//
//  ContentCellCollectionViewCell.swift
//  GetDataPixabay
//
//  Created by Yerassyl Orazbekov on 02.12.2021.
//

import UIKit

class ContentCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImage.image = nil
    }
}




























