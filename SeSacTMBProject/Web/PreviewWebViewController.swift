//
//  PreviewWebViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/07.
//

import UIKit

import Alamofire
import SwiftyJSON
import WebKit

class PreviewWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
  
    var movieID = 0
    var destinationURL = ""
    var previewHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo()
        openWebPage(url: "https://www.youtube.com/watch?v=\(destinationURL)")
        print(movieID, "======idididi")
        previewHandler?()
    }
  
    func getVideo() {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(APIKey.TMDBKey)&language=en-US"
        AF.request(url, method: .get).validate().responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                let movieKey = json["results"][0]["key"].stringValue
                DispatchQueue.main.async {
                    self.openWebPage(url: "https://www.youtube.com/watch?v=\(movieKey)")
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("invalid URL")
            return
        }
        let requst = URLRequest(url: url)
        webView.load(requst)
    }
    

    
}
