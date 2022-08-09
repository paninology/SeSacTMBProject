//
//  SearchViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI

class SearchViewController: UIViewController { //배우정보

    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var TMDBs:[TMDBContents] = []
    var genre: [Int: String] = [0:"??"]
    var currentPage = 1
    var totalPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellLayoutSetting()
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.prefetchDataSource = self
        searchCollectionView.register(UINib(nibName: SearchCollectionViewCell
            .reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
       
        requestGenre()
    }
    
    func cellLayoutSetting() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let cellWidth = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        self.searchCollectionView.collectionViewLayout = layout
    }
    
    func requestGenre() {
        let url = EndPoint.TMDBGenre + APIKey.TMBDKey + "&language=en-US"
        
        APIManager.share.requestTMBD(url: url) { json in
            for n in json["genres"].arrayValue {
                self.genre[n["id"].intValue] = n["name"].stringValue
            }
            self.requestTrending()
        }
    }
    
    func requestTrending() {  //[0].intValue
        let url = EndPoint.TMDBURL + APIKey.TMBDKey + "&page=\(currentPage)"
        APIManager.share.requestTMBD(url: url) { json in
            for n in json["results"].arrayValue { //map으로 바꿀 수 있을까/..
                self.TMDBs.append(TMDBContents(title: n["title"].stringValue, releaseDate: n["release_date"].stringValue, genre: [n["genre_ids"].intValue], imageURL: n["poster_path"].stringValue, rate: n["vote_average"].doubleValue, id: n["id"].intValue))
            }
            self.totalPage = json["total_pages"].intValue
            print(self.TMDBs)
            self.searchCollectionView.reloadData()
        }
    }
 

}
extension SearchViewController: UICollectionViewDataSourcePrefetching {
  
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
   
        for indexPath in indexPaths {
            if TMDBs.count - 1 == indexPath.item && TMDBs.count < totalPage {
                currentPage += 1
        
                requestTrending()

            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TMDBs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        
        cell.bottomView.layer.cornerRadius = 10
        cell.bottomView.clipsToBounds = true
//        cell.bottomView.layer.shadowRadius = 5
//        cell.bottomView.layer.shadowColor = CGColor(gray: 100, alpha: 0.5)
//        cell.bottomView.layer.shadowOffset = .init(width: 5, height: 5)
        
        cell.clipButton.backgroundColor = .white
        cell.clipButton.layer.cornerRadius = cell.clipButton.frame.height / 2
        cell.clipButton.tintColor = .black
        cell.rateNameLabel.backgroundColor = .systemIndigo
        cell.rateNameLabel.textColor = .white
        cell.rateNameLabel.font = .systemFont(ofSize: 12)
        cell.rateLabel.backgroundColor = .white
        cell.rateLabel.textColor = .black
        cell.rateLabel.font = .systemFont(ofSize: 12)
        cell.releaseDateLabel.font = .systemFont(ofSize: 14)
        cell.releaseDateLabel.textColor = .systemGray
        cell.detailButton.tintColor = .black
        
        cell.lineLabel.layer.borderWidth = 2
        
        cell.titleLabel.text = TMDBs[indexPath.row].title
        cell.posterImageView.kf.setImage(with: URL(string: EndPoint.TMBDImageURL + TMDBs[indexPath.row].imageURL))
        cell.rateLabel.text =  "  \((round(TMDBs[indexPath.row].rate * 10) / 10 ).description)  "
        cell.releaseDateLabel.text = TMDBs[indexPath.row].releaseDate
//        for n in 0...(self.genre[TMDBs[indexPath.row].genre.count - 1) {
//
//        }
        cell.genreLabel.text = self.genre[TMDBs[indexPath.row].genre[0]]
        print(self.genre[TMDBs[indexPath.row].genre[0]], self.genre)
        
        cell.clipButton.tag = indexPath.row
        cell.clipButton.addTarget(self, action: #selector(clipButtonClicked), for: .touchUpInside)
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as! DetailViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.TMBD = TMDBs[indexPath.row]
    }
    
    @objc func clipButtonClicked(sender: UIButton) {
        
        let sb = UIStoryboard(name: "Web", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: PreviewWebViewController.reuseIdentifier) as! PreviewWebViewController
        
        vc.movieID = self.TMDBs[sender.tag].id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
