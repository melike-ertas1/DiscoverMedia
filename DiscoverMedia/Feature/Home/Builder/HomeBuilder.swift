//
//  HomeBuilder.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation
import UIKit

final class HomeBuilder {
    class func make(viewModel: HomeViewModelProtocol)-> MainNavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
        let homeVC = navigationController.viewControllers.first as? HomeViewController
        homeVC?.viewModel = viewModel
        return navigationController
    }
}
