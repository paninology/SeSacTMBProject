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
    
    
}
