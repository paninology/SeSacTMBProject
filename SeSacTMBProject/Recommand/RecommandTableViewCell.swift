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
        
        self.backgroundColor = .lightGray
        cellLabel.textColor = .red
        cellLabel.font = .boldSystemFont(ofSize: 24)
    }

   
}
