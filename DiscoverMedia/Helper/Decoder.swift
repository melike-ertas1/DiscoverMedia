//
//  Decoder.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation

public enum Decoders {
//    data decode part
    public static let mainDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Decoders.dateFormat
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public static let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //"2006-03-24T22:30:00Z"
}
