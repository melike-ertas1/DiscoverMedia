//
//  MediaCollectionViewCell.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import UIKit
import Kingfisher

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: RoundedView!
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    func configure(with mediaModel: MediaDetail) {
        let dateConvert = mediaModel.releaseDate?.convertToString()
        date.text = dateConvert
        price.text = "\(mediaModel.collectionPrice ?? 0) $"
        name.text = mediaModel.collectionName
        mediaImage.kf.indicatorType = .activity
        if let urlString = mediaModel.artworkUrl100, let url = URL(string: urlString) {
            let resource = ImageResource(downloadURL: url)
            mediaImage.kf.setImage(
                with: resource,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size: mediaImage.bounds.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])
        }
        
    }
}
