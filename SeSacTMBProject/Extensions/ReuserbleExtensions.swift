//
//  ViewControllerExtensions.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/03.
//

import UIKit

extension UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
