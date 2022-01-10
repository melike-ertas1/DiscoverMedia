//
//  HomeService.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation
import Moya

class HomeService: ServiceProtocol {
    var provider: MoyaProvider<API>!
    
    required init(isMock: Bool) {
        if isMock {
            provider = MoyaProvider<API>(stubClosure: MoyaProvider.immediatelyStub, plugins: self.moyaPlugins())
        } else {
            provider = MoyaProvider<API>(stubClosure: MoyaProvider.neverStub, plugins: self.moyaPlugins())
        }
    }
    
    
    func getSegmentSearchData(limit: Int, offset: Int, searchText: String,type:String, completion: @escaping (Result<MediaModel, APIError>) -> Void) {
        self.provider.request(.getSegmentSearchData(limit: limit, offset: offset, searchText: searchText, type: type)) { result in
            switch result {
            case .success(let response):
                print(response)

                if let mediaList = response.parseCodableModel(type: MediaModel.self) {
                    completion(.success(mediaList))
                } else {
                    completion(.failure(.parseError))
                }
                
            case .failure(let error):
                let errorMessage = self.getResponseError(from: error)
                completion(.failure(errorMessage))
                break
            }
        }
    }
}
