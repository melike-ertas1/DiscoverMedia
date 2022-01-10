//
//  DateConverter.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 6.01.2022.
//

import Foundation
import UIKit

class DateConverter{

    class func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"  //2015-01-23T12:00:00Z
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return  dateFormatter.string(from: date ?? Date())
        }
}
