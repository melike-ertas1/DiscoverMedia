//
//  RoundedImageView.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 6.01.2022.
//

import Foundation
import UIKit


class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        self.contentMode = .scaleAspectFill
        
    }
}
