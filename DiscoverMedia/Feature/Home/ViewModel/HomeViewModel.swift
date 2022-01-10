//
//  HomeViewModel.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation


final class HomeViewModel: HomeViewModelProtocol {

    private var service: HomeService
    var delegate: HomeViewModelDelegate?
    private var medias:[MediaDetail] = []
    private var count = 0
    private let  limit = 20
    private var offset = 0

    init(isMock: Bool = false) {
        service = HomeService(isMock: isMock)
    }

//    go to detail page
    func selectMedia(detail: MediaDetail) {
        let viewModel = DetailViewModel(detail: detail)
        self.delegate?.navigate(.toMediaDetail(viewModel))
    }
    
// api call method
    func getSegmentSearchData(searchText: String, type: String) {
        service.getSegmentSearchData(limit: limit, offset: offset, searchText: searchText, type: type) { [weak self] result in
            guard  let self = self else {return}
            self.delegate?.handleHomeViewModelOutput(.isLoading(false))
            switch result {
            case .success(let mediaList):
                if mediaList.resultCount ?? 0 > 0{
                    self.count = mediaList.resultCount ?? 0
                    self.medias.append(contentsOf: mediaList.results)
    //                first search data
                    if self.offset == 0 {self.offset = self.limit}
                    self.delegate?.handleHomeViewModelOutput(.showMediaList(self.medias))
                }
                else{
                    self.delegate?.navigate(.toErrorPage)
                }
                break
            case .failure(let error):
                self.delegate?.handleHomeViewModelOutput(.showError(error.localizedDescription))
                break
            }
        }
    }
    
    func getNextPage(searchText: String, type: String) {
//        pagination control
        guard count == limit else {return}
        offset += limit
        getSegmentSearchData(searchText: searchText, type: type)
    }
    
    func deleteSearch(){
        self.medias.removeAll()
        self.offset = 0
    }

    
    
}
