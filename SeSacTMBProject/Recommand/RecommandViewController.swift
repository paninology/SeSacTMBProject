//
//  RecommandViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/09.
//

import UIKit

class RecommandViewController: UIViewController {

    @IBOutlet weak var recommandTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recommandTableView.dataSource = self
        recommandTableView.delegate = self
        
        APIManager.share.requestTMBDRecommend( movieId: 725201, page: 1) { json in
            print(json)
            for n in json["results"].arrayValue {
                self.recommendList.append(Recommend(id: n["id"].intValue, posterPath: n["poster_path"].stringValue, title: n["title"].stringValue, genre: [n["genre_ids"][0].intValue], overView: n["overview"].stringValue))
                
            }
            print(self.recommendList)
        }
      
    }
    
    
    
}

extension RecommandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommandTableViewCell.reuseIdentifier) as? RecommandTableViewCell else {
            return UITableViewCell()
        }
        cell.recommandCollectionView.dataSource = self
        cell.recommandCollectionView.delegate = self
        cell.recommandCollectionView.collectionViewLayout = collectionViewLayout()
        cell.recommandCollectionView.register(UINib(nibName: "NewRecommandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewRecommandCollectionViewCell") //xib 오류나서 일단 일반셀로 만듬>>>결국 다시 지우고 만듬
        
        return cell
    }
    
}

extension RecommandViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCell", for: indexPath) as? NewCollectionViewCell else { return UICollectionViewCell() } //xib 오류나서 일단 일반셀로 만듬>>>결국 다시 지우고 만듬
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewRecommandCollectionViewCell", for: indexPath) as? NewRecommandCollectionViewCell else { return UICollectionViewCell() }
        
        self.recommandTableView.tag = indexPath.section
        cell.movieView.movieLabel.text = recommendList[indexPath.section].title
        
        
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width , height: 200)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0 )
        
        return layout
    }
    
    
    
}
