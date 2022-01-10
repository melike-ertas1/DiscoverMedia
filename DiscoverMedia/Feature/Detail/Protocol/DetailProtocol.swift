//
//  DetailProtocol.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 6.01.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var delegate: DetailViewModelDelegate? {get set}
    var mediaDetail: MediaDetail {get}
    
    func showDetailData()
    
}

protocol DetailViewModelDelegate: AnyObject {
    func handleDetailViewModelOutput(output: DetailViewModelOutput)
    // Bir önceki sayfaya data gönderme // call back
}

enum DetailViewModelOutput {
    case isLoading(Bool)
    case showDetailData  // 2. yöntemle data gösterme
    case showError(String)
}
