//
//  MediaModel.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation

struct MediaModel: Codable{
    
    var resultCount:Int?
    var results: [MediaDetail]
}


struct MediaDetail: Codable{
    
    var wrapperType: String?
    var collectionName: String?
    var artworkUrl100: String?
    var collectionPrice: Double?
    var releaseDate:Date?
    var artistName: String?
    var trackName: String?
    
}
