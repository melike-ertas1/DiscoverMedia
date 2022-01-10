//
//  Spinner.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 10.01.2022.
//

import Foundation
import UIKit

class Spinner {
    internal static var spinner: UIActivityIndicatorView?
    
    class func start(frame: CGRect = UIScreen.main.bounds, color: UIColor = .black, scale: CGFloat = 1) {
        if spinner == nil, let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}){
            let frame = frame
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.color = color
            if scale != 1 {
                spinner?.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    class func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
}
