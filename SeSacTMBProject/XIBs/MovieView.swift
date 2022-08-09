//
//  MovieView.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/09.
//

import UIKit

class MovieView: UIView {

    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "MovieView", bundle: nil).instantiate(withOwner: self).first as! UIView
        
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
    
    
}
