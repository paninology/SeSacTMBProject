//
//  RecommandTableViewCell.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/09.
//

import UIKit

class RecommandTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var recommandCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("kkkkkkk")
        
        self.backgroundColor = .lightGray
       
        setupUI()
    }

    func setupUI() {
        cellLabel.textColor = .red
        cellLabel.font = .boldSystemFont(ofSize: 24)
        cellLabel.text = " 콘텐츠"
        
        recommandCollectionView.backgroundColor = .blue
        recommandCollectionView.collectionViewLayout = collectionViewLayout()
    }
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return layout
        
    }
}
