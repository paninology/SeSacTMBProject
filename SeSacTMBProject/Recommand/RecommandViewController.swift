//
//  RecommandViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/09.
//

import UIKit

class RecommandViewController: UIViewController {

    @IBOutlet weak var recommandTableView: UITableView!
    
    var recommendList: [Recommend] = []
    var posterList: [[String]] = []
    var posterName: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recommandTableView.dataSource = self
        recommandTableView.delegate = self
        
        APIManager.share.requestTrending(page: 1) { posters, name in
            self.posterList = posters
            self.posterName = name
            self.recommendList = APIManager.share.recommendList
            self.recommandTableView.reloadData()
            dump(self.posterList)
            dump(self.recommendList)
            print("recommendList=======", self.recommendList[0],self.recommendList[1])
            
        }
     
    }
}

extension RecommandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
   
        return posterList.count
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
//        cell.recommandCollectionView.collectionViewLayout = collectionViewLayout()
        cell.recommandCollectionView.tag = indexPath.section
        cell.recommandCollectionView.register(UINib(nibName: "NewRecommandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewRecommandCollectionViewCell") //xib 오류나서 일단 일반셀로 만듬>>>결국 다시 지우고 만듬
        cell.cellLabel.text = recommendList[indexPath.section].title + "과 비슷한 영화"
        cell.recommandCollectionView.reloadData() //Index 오류를 해결해 준다.
        
        return cell
    }
    
}

extension RecommandViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        posterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        return posterList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCell", for: indexPath) as? NewCollectionViewCell else { return UICollectionViewCell() } //xib 오류나서 일단 일반셀로 만듬>>>결국 다시 지우고 만듬
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewRecommandCollectionViewCell", for: indexPath) as? NewRecommandCollectionViewCell else { return UICollectionViewCell() }
        
        self.recommandTableView.tag = indexPath.section
        let url = EndPoint.TMBDImageURL + posterList[collectionView.tag][indexPath.item]
        cell.movieView.movieImageView.kf.setImage(with: URL(string: url))
        cell.movieView.movieLabel.text = posterName[collectionView.tag][indexPath.item]
        cell.movieView.movieLabel.textColor = .white
        
        
        return cell
    }
    
    /*
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2.5 ) , height: 250)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0 )
        
        return layout
    }
     */
    
    
    
}
