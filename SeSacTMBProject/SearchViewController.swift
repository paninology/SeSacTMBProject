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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellLayoutSetting()
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(UINib(nibName: SearchCollectionViewCell
            .reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        
        
        
        
        requestTMBD()
        
        
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
    
    
    func requestTMBD() {
        
        let url = EndPoint.TMDBURL + APIKey.TMBDKey
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for n in json["results"].arrayValue {
          
                    self.TMDBs.append(TMDBContents(title: n["title"].stringValue, releaseDate: n["release_date"].stringValue, genre: [n["genre_ids"].stringValue], imageURL: n["poster_path"].stringValue, rate: n["vote_average"].doubleValue))
                    print( n["title"])
                }
         
                self.searchCollectionView.reloadData()
                        
            case .failure(let error):
                print(error)
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
        
        cell.posterImageView.image
        
        cell.titleLabel.text = TMDBs[indexPath.row].title
        cell.posterImageView.kf.setImage(with: URL(string: EndPoint.TMBDImageURL + TMDBs[indexPath.row].imageURL))
        cell.rateLabel.text =  ( round(TMDBs[indexPath.row].rate * 10) / 10 ).description
        cell.releaseDateLabel.text = TMDBs[indexPath.row].releaseDate
        
        return cell
    }
    
    
}
