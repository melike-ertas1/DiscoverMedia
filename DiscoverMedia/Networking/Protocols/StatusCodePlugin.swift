//
//  StatusCodePlugin.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation
import Moya
import Reachability

public final class StatusCodePlugin: PluginType {
    
    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        
        guard hasConnectivity() else { return .failure(.parameterEncoding(APIError.connectionError)) }
        
        switch result {
        case .success(let response):
            if response.statusCode > 299 {
                return .failure(.jsonMapping(response))
            }
            return .success(response)
        
        case .failure(let error):
            print(error)
            return .failure(.parameterEncoding(APIError.generalError))
        }
    }
    
    private func hasConnectivity() -> Bool {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .wifi:
            //debugPrint("Reachable via WiFi")
            return true
        case .cellular:
            //debugPrint("Reachable via Cellular")
            return true
        case .none:
            //debugPrint("Network not reachable")
            return false
        case .unavailable:
            return false
        }
    }
    
    private func checkConnection() -> Bool{
        if  !self.hasConnectivity() {
            return false
        }
        return true
    }
}
