//
//  MoyaResponseExtension.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation
import Moya

//dynamic parse extension
extension Moya.Response {
    func parseCodableModel<T: Codable>(type: T.Type) -> T? {
        do {
            let parsedModel = try Decoders.mainDecoder.decode(type.self, from: self.data)
            return parsedModel
        } catch {
            #if DEBUG
            print(error)
            #endif
            return nil
        }
    }
}
