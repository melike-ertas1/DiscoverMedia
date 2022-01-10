//
//  DateExtension.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 9.01.2022.
//

import Foundation

extension Date {

    
    func convertToString(format:DateFormatsInApplication = .mediaDateFormat ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")

        let dateString = formatter.string(from: self)
        return dateString
    }
    
}


enum DateFormatsInApplication: String {
    case apiDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case mediaDateFormat = "dd.MM.YYYY"
}

