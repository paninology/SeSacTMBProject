//
//  SearchCollectionViewCell.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/05.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var rateNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var clipButton: UIButton!
    
    @IBOutlet weak var detailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
