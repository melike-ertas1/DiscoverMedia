//
//  HomeViewController.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 5.01.2022.
//

import UIKit
import IQKeyboardManagerSwift

enum SelectedScope:String{
    case movies = "movie"
    case music = "musicTrack"
    case podcast = "podcast"
    case books = "ebook"
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegment: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: ErrorView!
    
    private var workItem: DispatchWorkItem?
    private var mediaList: [MediaDetail] = []
    private var filterMediaList: [MediaDetail] = []
    var searchText: String?
    var searchType: String?
    var currentCount = 0
    var viewModel: HomeViewModelProtocol! {
        didSet{
            self.viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        searchBar.delegate = self
        filterSegment.selectedSegmentIndex = 1
        self.searchText = "Top 100"
        self.searchType =  SelectedScope.music.rawValue
        viewModel.getSegmentSearchData( searchText: self.searchText! , type: SelectedScope.music.rawValue)
        errorView.isHidden = true
        keyboardSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Discover Medias"
    }
    @IBAction func didChangeSegment(_ sender:UISegmentedControl){
        searchMedia(sender: sender)
    }
    
    private func searchMedia(sender:UISegmentedControl){
        if let text = self.searchText{
            viewModel.deleteSearch()
            if sender.selectedSegmentIndex == 0{
                viewModel.getSegmentSearchData( searchText: text , type: SelectedScope.movies.rawValue)
            }
            if sender.selectedSegmentIndex == 1{
                viewModel.getSegmentSearchData( searchText: text , type: SelectedScope.music.rawValue)
            }
            if sender.selectedSegmentIndex == 2{
                viewModel.getSegmentSearchData( searchText: text , type: SelectedScope.books.rawValue)
            }
            if sender.selectedSegmentIndex == 3{
                viewModel.getSegmentSearchData(searchText: text , type: SelectedScope.podcast.rawValue)
            }
        }
    }
    
    private func keyboardSet(){
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
    }
}

extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterMediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell else {fatalError("Cell not found")}
        let media = filterMediaList[indexPath.row]
        cell.configure(with: media)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = filterMediaList[indexPath.row]
        self.viewModel.selectMedia(detail: media)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        pagination control check last cell
        if indexPath.row == mediaList.count - 1{
            viewModel.getNextPage(searchText: searchText ?? "" , type: self.searchType ?? "")
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 7,bottom: 0,right: 7)
        layout.minimumInteritemSpacing = 7
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 28) / 2, height:(self.collectionView.frame.size.height) / 1.9)
        return layout.itemSize
    }
}



extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else {
            self.filterMediaList.removeAll()
            self.collectionView.reloadData()
            return
        }
// block repeated api calls
        workItem?.cancel()
        let tempWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else {return}
            self.searchText = searchText
            self.searchMedia(sender: self.filterSegment)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: tempWorkItem)
        self.workItem = tempWorkItem
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func handleHomeViewModelOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            DispatchQueue.main.async {
                isLoading ? Spinner.start() : Spinner.stop()
            }
            break
        case .showMediaList(let myMediaList):
//            get api result and load collection view
            errorView.isHidden = true 
            self.filterMediaList = myMediaList
            self.mediaList = myMediaList
            self.collectionView.reloadData()
            break
        case .showError(let errorMessage):
            break
        }
    }
    
    func navigate(_ router: HomeRouter) {
        switch router {
        case .toMediaDetail(let viewModel):
            let detailVC = DetailBuilder.make(viewModel: viewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
            break
        case .toErrorPage:
            self.mediaList.removeAll()
            self.filterMediaList.removeAll()
            self.collectionView.reloadData()
            errorView.isHidden = false
            break
          
        }
    }
}

