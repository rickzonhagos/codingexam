//
//  DetailViewController.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 04/11/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    var presenter : DetailPresenterProtocol!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.doShowVenue()
    }
}
extension DetailViewController : DetailViewProtocol {
    func showVenue(_ venue: Venue!) {
        self.name.text = venue.name
        self.address.text = venue.address
    }
    
    
}
