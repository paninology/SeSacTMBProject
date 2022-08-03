//
//  SearchViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {

    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var titles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        requestTMBD()
        
    }
    
    func requestTMBD() {
        
        let url = EndPoint.TMDBURL + APIKey.TMBDKey
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON:", json)
                for n in json["result"].arrayValue {
                    self.titles.append(n["title"].stringValue)
                }
                print(self.titles)
                        
            case .failure(let error):
                print(error)
            }
        }
            
    }
  

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        
        return cell
    }
    
    
}
