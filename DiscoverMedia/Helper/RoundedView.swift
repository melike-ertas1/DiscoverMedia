//
//  RoundedView.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 6.01.2022.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        self.layer.shadowRadius = 6
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.borderColor = UIColor.lightGray.cgColor

    }

}
