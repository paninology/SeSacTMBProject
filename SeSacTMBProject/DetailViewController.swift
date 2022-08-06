//
//  DatailViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/06.
//

import UIKit

import Kingfisher

class DetailViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var smallImageView: UIImageView!
    
    
    var TMBD: TMDBContents = TMDBContents(title: "default", releaseDate: "", genre: [0], imageURL: "", rate: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
     
        
        print(TMBD, "detail tmbd======")
       
//        backImageView.layer.opacity = 0.5
        
        backImageView.kf.setImage(with: URL(string: EndPoint.TMBDImageURL + TMBD.imageURL))
        smallImageView.kf.setImage(with: URL(string: EndPoint.TMBDImageURL + TMBD.imageURL))
        titleLabel.text = TMBD.title
       
    }
    
    func requestCasting() {
        //AF: 200-299 status code 가 성공인데 커스텀으로 추가 하고싶으면 validate
        let url = "https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=\(APIKey.TMBDKey)&language=en-US"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON:", json)
                
            case .failure(let error):
                print(error)
            }
        }
    }

  

}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        400
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        
        
        
        cell.crewImageView.kf.setImage(with: URL(string: EndPoint.TMBDImageURL + TMBD.imageURL))
        
        cell.titleLabel.text = TMBD.title
        cell.subTitleLabel.text = TMBD.title
        
        
        return cell
    }
  
    
}



