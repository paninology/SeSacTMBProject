//
//  DatailViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/06.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON


class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var smallImageView: UIImageView!
    
    var TMBD: TMDBContents = TMDBContents(title: "default", releaseDate: "", genre: [0], imageURL: "", rate: 0, id: 0)
    var casting: [Castings] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
  
//        backImageView.layer.opacity = 0.5
        
        backImageView.kf.setImage(with: URL(string: EndPoint.TMBDImageURL + TMBD.imageURL))
        smallImageView.kf.setImage(with: URL(string: EndPoint.TMBDImageURL + TMBD.imageURL))
        
        titleLabel.text = TMBD.title
        requestCasting()
       
    }
    
    func requestCasting() {

        let url = "https://api.themoviedb.org/3/movie/\(TMBD.id)/credits?api_key=\(APIKey.TMDBKey)&language=en-US"
        APIManager.share.requestTMBD(url: url) { json in
            for n in json["cast"].arrayValue {
                self.casting.append(Castings(name: n["name"].stringValue, id: n["id"].intValue, department: n["known_for_department"].stringValue, imagePath: n["profile_path"].stringValue))
                
            }
            self.tableView.reloadData()
        }
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        casting.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        400
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        
        cell.crewImageView.kf.setImage(with: URL(string: "https://api.themoviedb.org/3/person/\(casting[indexPath.row].id)/images?api_key" + APIKey.TMDBKey + casting[indexPath.row].imagePath))
        
        cell.titleLabel.text = self.casting[indexPath.row].name
        cell.subTitleLabel.text = self.casting[indexPath.row].department
        
        
        return cell
    }
  
    
}



