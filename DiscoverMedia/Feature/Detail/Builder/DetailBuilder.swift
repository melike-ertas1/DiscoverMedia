//
//  DetailBuilder.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 6.01.2022.
//

import Foundation
import UIKit

final class DetailBuilder {
    
    class func make(viewModel: DetailViewModelProtocol) -> DetailViewController {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailViewController") { coder -> DetailViewController? in
            return DetailViewController(coder: coder, viewModel: viewModel)
        }
        return detailVC
    }
    
}

