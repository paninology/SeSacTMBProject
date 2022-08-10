//
//  Model.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/05.
//

import Foundation

struct TMDBContents {
    let title: String
    let releaseDate: String
    let genre: [Int]
    let imageURL: String
    let rate: Double
    let id: Int
//    let actors: [String]?
}

struct Castings {
    let name: String
    let id: Int
    let department: String
    let imagePath: String
}

struct Recommend {
    let id: Int
    let posterPath: String
    let title: String
    let genre: [Int]
    let overView: String
}
