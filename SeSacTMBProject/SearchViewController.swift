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

class SearchViewController: UIViewController {

    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var TMDBs:[TMDBContents] = []
    var genre: [Int: String] = [0:"??"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellLayoutSetting()
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(UINib(nibName: SearchCollectionViewCell
            .reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
       
        requestTMBD()
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
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("genre++++++++",json)
                for n in json["genres"].arrayValue {
//                    print("n============",n)
                    self.genre[n["id"].intValue] = n["name"].stringValue
                }
                self.searchCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestTMBD() {
        
        let url = EndPoint.TMDBURL + APIKey.TMBDKey
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for n in json["results"].arrayValue {
          
                    self.TMDBs.append(TMDBContents(title: n["title"].stringValue, releaseDate: n["release_date"].stringValue, genre: [n["genre_ids"][0].intValue], imageURL: n["poster_path"].stringValue, rate: n["vote_average"].doubleValue))
//                    print( n["title"])
                }
         
                self.searchCollectionView.reloadData()
                        
            case .failure(let error):
                print(error)
            }
        }
            
    }
  

}
extension SearchViewController: UICollectionViewDataSourcePrefetching {
  
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
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
        cell.genreLabel.text = self.genre[TMDBs[indexPath.row].genre[0]]
        
        print(TMDBs)

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as! DetailViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.TMBD = TMDBs[indexPath.row]
    }
    
    
}
