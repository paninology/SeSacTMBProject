//
//  NewCollectionViewCell.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/09.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {  ////안쓰는 파일...
    
    @IBOutlet weak var movieView: MovieView!
    
    @IBOutlet weak var centerLabel: UILabel!
    
    
    override func awakeFromNib() {
        print("ttttttt")
        setupUI()
    }
    
    func setupUI() {
        movieView.backgroundColor = .systemPink
        centerLabel.text = "testing..."
      
    }
    
    
}
