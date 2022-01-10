//
//  DetailViewController.swift
//  DiscoverMedia
//
//  Created by melike ertaş on 6.01.2022.
//

import UIKit
import Kingfisher


class DetailViewController: UIViewController {
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var image: RoundedImageView!
    
    var viewModel: DetailViewModelProtocol
    
    init?(coder: NSCoder, viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.showDetailData()
    }
    
    private func updateUI(mediaDetail: MediaDetail?) {
        let dateConvert = mediaDetail?.releaseDate?.convertToString()
        releaseDate.text = dateConvert
        artistName.text = mediaDetail?.artistName
        price.text = "\(mediaDetail?.collectionPrice ?? 0) $"
        collectionName.text = mediaDetail?.collectionName
        trackName.text = mediaDetail?.trackName
        
        image.kf.indicatorType = .activity
        if let urlString = mediaDetail?.artworkUrl100, let url = URL(string: urlString) {
            let resource = ImageResource(downloadURL: url)
            image.kf.setImage(
                with: resource,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size: image.bounds.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])
        }
   
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func handleDetailViewModelOutput(output: DetailViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            DispatchQueue.main.async {
                isLoading ? Spinner.start() : Spinner.stop()
            }
            break
        case .showDetailData:
            updateUI(mediaDetail: viewModel.mediaDetail)
            break
        case .showError(let error):
            break
        }
    }
    
}
