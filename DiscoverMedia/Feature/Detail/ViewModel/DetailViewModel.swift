//
//  DetailViewModel.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 6.01.2022.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol {
    var mediaDetail: MediaDetail
    weak var delegate: DetailViewModelDelegate?

    init(isMock: Bool = false, detail : MediaDetail) {
        self.mediaDetail = detail
    }
    
    func showDetailData(){
        self.delegate?.handleDetailViewModelOutput(output: .showDetailData)
    }

    
}

