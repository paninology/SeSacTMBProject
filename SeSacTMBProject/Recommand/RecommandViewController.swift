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
//        cell.recommandCollectionView.register(UINib(nibName: "RecommandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommandCollectionViewCell") //xib 오류나서 일단 일반셀로 만듬
        
        return cell
    }
    
}

extension RecommandViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCell", for: indexPath) as? NewCollectionViewCell else { return UICollectionViewCell() } //xib 오류나서 일단 일반셀로 만듬
        
        
        
        
        
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
