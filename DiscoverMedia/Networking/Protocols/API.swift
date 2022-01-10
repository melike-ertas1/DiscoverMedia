//
//  API.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation
import Moya

enum API {
    case getSegmentSearchData(limit: Int, offset: Int,searchText: String, type:String)

}
// API URL, path, method
extension API: TargetType {
    var baseURL: URL { return URL(string: "https://itunes.apple.com/search?)")! }
    
    var path: String {
        switch self {
        case .getSegmentSearchData(let limit, let offset,let searchText,let type):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSegmentSearchData:
            return .get

        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getSegmentSearchData( let limit, let offset,let searchText,let type):
            let parameters: [String: Any] = ["limit": limit, "offset":offset, "term":searchText, "entity":type]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json",
        "Content-Type": "application/json"]
    }
}
