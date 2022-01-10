//
//  RootRouter.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation
import UIKit

class RootRouter {

    private func setRootViewController(controller: UIViewController, animatedWithOptions: UIView.AnimationOptions?) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            fatalError("No window in app")
        }
        if let animationOptions = animatedWithOptions, window.rootViewController != nil {
            window.rootViewController = controller
            UIView.transition(with: window, duration: 0.33, options: animationOptions, animations: {
            }, completion: nil)
        } else {
            window.rootViewController = controller
        }
    }

    func loadMainAppStructure() {
        let controller = HomeBuilder.make(viewModel: HomeViewModel())
        setRootViewController(controller: controller, animatedWithOptions: nil)
    }
}
