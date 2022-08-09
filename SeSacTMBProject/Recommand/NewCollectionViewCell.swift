//
//  NewCollectionViewCell.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/09.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieView: MovieView!
    
    override func awakeFromNib() {
        print("ttttttt")
        setupUI()
    }
    
    func setupUI() {
        movieView.backgroundColor = .black
      
    }
    
    
}
