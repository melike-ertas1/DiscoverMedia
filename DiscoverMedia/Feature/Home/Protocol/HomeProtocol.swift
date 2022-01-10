//
//  HomeProtocol.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import Foundation


protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    func selectMedia(detail: MediaDetail)
    func getSegmentSearchData(searchText: String,type: String)
    func getNextPage(searchText: String, type: String)
    func deleteSearch()

}

protocol HomeViewModelDelegate: AnyObject {
    func handleHomeViewModelOutput(_ output: HomeViewModelOutput)
    func navigate(_ router: HomeRouter)
}

enum HomeViewModelOutput {
    case isLoading(Bool)
    case showMediaList([MediaDetail])
    case showError(String)
}

enum HomeRouter {
    case toMediaDetail(DetailViewModelProtocol)
    case toErrorPage
}

