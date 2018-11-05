//
//  ListViewController.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit
import CoreLocation

class ListViewController: UIViewController {
    
    var locationManager : CLLocationManager!
    var presenter : ListViewPresenterProtocol!
    var venueList : [Venue]!
    static let CellIdentifier = "VenueTableViewCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForLocationServices()
        initVIPER()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ListViewController {
    func checkForLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                let alertController : UIAlertController = UIAlertController(title: "Ooppss", message: Constants.Message.AllowLocaionService, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    
                }
                let goToSettings = UIAlertAction(title: "Settings", style: .default) { (action) in
                    if let url = URL(string: UIApplicationOpenSettingsURLString) {
                        
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
                alertController.addAction(okAction)
                alertController.addAction(goToSettings)
                self.present(alertController, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                initLocationManager()
            }
        } else {
            let alertController : UIAlertController = UIAlertController(title: "Ooppss", message: Constants.Message.TurnOnLocation, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            let goToSettings = UIAlertAction(title: "Settings", style: .default) { (action) in
                if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION_SERVICES") {
                    
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            
            alertController.addAction(okAction)
            alertController.addAction(goToSettings)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func initLocationManager(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    func initVIPER(){
        let interactor = ListViewInteractor()
        let router = ListViewRouter()
        let presenter = ListViewPresenter(withViewProtocol: self, interactorProtocol: interactor, router: router)
        interactor.callBackHandler = presenter
        self.presenter = presenter
    }
}
extension ListViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            presenter.doSearchVenues(withLongitude: "\(longitude)", latitude: "\(latitude)")
            manager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alertController : UIAlertController = UIAlertController(title: "Ooppss", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
extension ListViewController : ListViewProtocol {
    func showVenueList(_ list: [Venue]!) {
        self.venueList = list
        self.tableView.reloadData()
    }
    
    func showErrorMsg(_ msg: String!) {
        let alertController = UIAlertController(title: "Hello!", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let venueList = self.venueList else {
            return
        }
        self.presenter.navigateToDetailsPage(venueList[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard  let venueList = self.venueList else {
            return 0
        }
        return venueList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListViewController.CellIdentifier) as! VenueTableViewCell
        let venue = self.venueList[indexPath.row]
        cell.setVenue(venue)
        return cell
    }
}
