//
//  APIManagers.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON


class APIManager {
    
    static let share = APIManager()
    private init() { }
    
    var trendList: [TMDBContents] = []
    var recommendList: [Recommend] = []
    
    func requestTMBD(url: String, compelteHandler: @escaping (JSON) -> () ) {
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                compelteHandler(json)
              
            case .failure(let error):
                print(error)
            }
        }
            
    }
    
    func requestTrending(page: Int, compelteHandler: @escaping ([[String]],[[String]]) -> ()) {  //[0].intValue
        let url = EndPoint.TMDBURL + APIKey.TMBDKey + "&page=\(page)"
        APIManager.share.requestTMBD(url: url) { json in
            for n in json["results"].arrayValue { //map으로 바꿀 수 있을까/..
                self.trendList.append(TMDBContents(title: n["title"].stringValue, releaseDate: n["release_date"].stringValue, genre: [n["genre_ids"].intValue], imageURL: n["poster_path"].stringValue, rate: n["vote_average"].doubleValue, id: n["id"].intValue))
            }
            self.requesRecommendImage { posters, name in
                compelteHandler(posters, name)
            }
           
        }
    }
    
    func requestTMBDRecommend( movieId: Int, page: Int, compelteHandler: @escaping ([String], [String]) -> () ) {

        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/recommendations?api_key=\(APIKey.TMBDKey)&language=ko-KR&\(page)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if self.recommendList.count <= json["results"].count { //느리면 숫자 제한하기
                    for n in json["results"].arrayValue {
                        self.recommendList.append(Recommend(id: n["id"].intValue, posterPath: n["poster_path"].stringValue, title: n["title"].stringValue, genre: [n["genre_ids"][0].intValue], overView: n["overview"].stringValue))
                        
                    }
                    
                }
                let posterPath = json["results"].arrayValue.map { $0["poster_path"].stringValue }
                let posterName = json["results"].arrayValue.map { $0["title"].stringValue }
                
                compelteHandler(posterPath, posterName)
              
            case .failure(let error):
                print(error)
            }
        }
            
    }
    
    func requesRecommendImage(completionHandler: @escaping ([[String]],[[String]])-> ()) {
      
        var posterList: [[String]] = [] //두개 합쳐서 튜플로 만들던지. self.recommendList에 하나씩 초기화 해서 추가하던지
        var posterName: [[String]] = []
        
       
        requestTMBDRecommend(movieId: trendList[0].id, page: 1) { value, name in
            posterList.append(value)
            posterName.append(name)

            self.requestTMBDRecommend(movieId: self.trendList[1].id, page: 1) { value, name in
                posterList.append(value)
                posterName.append(name)

                self.requestTMBDRecommend(movieId: self.trendList[2].id, page: 1) { value, name in
                    posterList.append(value)
                    posterName.append(name)
                   
                    self.requestTMBDRecommend(movieId: self.trendList[3].id, page: 1) { value, name in
                        posterList.append(value)
                        posterName.append(name)
                     
                        self.requestTMBDRecommend(movieId: self.trendList[4].id, page: 1) { value, name in
                            posterList.append(value)
                            posterName.append(name)
                           
                            self.requestTMBDRecommend(movieId: self.trendList[5].id, page: 1) { value, name in
                                posterList.append(value)
                                posterName.append(name)
                                
                                self.requestTMBDRecommend(movieId: self.trendList[6].id, page: 1) { value, name in
                                    posterList.append(value)
                                    posterName.append(name)
                                    
                                    self.requestTMBDRecommend(movieId: self.trendList[7].id, page: 1) { value, name in
                                        posterList.append(value)
                                        posterName.append(name)
                                        completionHandler(posterList, posterName)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}
