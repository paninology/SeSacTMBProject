//
//  MovieView.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/10.
//

import UIKit

class MovieView: UIView {

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieLabel: UILabel!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
      
        let view = UINib(nibName: "MovieView", bundle: nil).instantiate(withOwner: self).first as! UIView
        
        view.backgroundColor = .blue
        self.addSubview(view)
        
        //카드뷰를 인터페이스 빌더 기반으로 만들고, 오토레이아앗도 설정했는데 왜 트루냐......
        //addSubView를 하는 과정이 코드로 뷰를 만들었다고 보기 때문
        //오토리사이징이 내부적으로 constraints 처리를 해주는것....
   
    }

}
