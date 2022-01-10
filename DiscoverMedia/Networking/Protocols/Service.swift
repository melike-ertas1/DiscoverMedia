//
//  Service.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation
import Moya

protocol ServiceProtocol: ErrorProtocol {
    var provider: MoyaProvider<API>! { get set }
    init(isMock:Bool)
}
extension ServiceProtocol {
    func moyaPlugins() -> [PluginType] {
        return [StatusCodePlugin()]
    }
}
