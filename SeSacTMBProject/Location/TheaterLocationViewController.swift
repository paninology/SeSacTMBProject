//
//  TheaterLocationViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/11.
//

import UIKit
import MapKit

class TheaterLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //37.517829, 126.886270
        let defaultCenter = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        setCenterAndAnnotations(center: defaultCenter)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showRequestLocationServiceAlert() //옮길것.
    }
    
    func setCenterAndAnnotations(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = " 신성한 배움의 전당 "
        mapView.addAnnotation(annotation)
    }
    
    func setAnnotations() {
        var annotations : [MKPointAnnotation]
        
        for i in TheaterList.mapAnnotations {
            
        }
        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
//        
//        mapView.addAnnotations(<#T##annotations: [MKAnnotation]##[MKAnnotation]#>)
        
        
    }
    

}
extension TheaterLocationViewController { //접근권한에 대한 익스텐션
        
    func checkUserDeviceLocationAuothorization() { //내위치 기능 자체를 허용하는가
        let authorizationStatus : CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져있음. 위치 서비스 설정 요망")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            print("not determined")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Denied, 아이폰 설정으로 유도")
//        case .authorizedAlways:
//            <#code#>
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() //didUpdateLocations 호출
//        case .authorized:
//            <#code#>
        default: print("default")
        }
        
        
    }
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          //설정화면까지 이동 / 설정 세부화면까지 이동
          //한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이거나에 따라 다르다c
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
          
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    
}

extension TheaterLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if let coordinate = locations.last?.coordinate {
            setCenterAndAnnotations(center: coordinate)
            print("new location annotaion======",coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationAuothorization() //권한 상태 바뀌면 자동으로 실행됨
    }
}

extension TheaterLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) { //지도 움직일때
        locationManager.startUpdatingLocation()
    }
}
