//
//  DetailPresenter.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 04/11/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

class DetailPresenter: NSObject {
    public private(set) weak var viewProtocol : DetailViewProtocol!
    public private(set) var interactorProtocol : DetailInteractorProtocol!
    init(withViewProtocol viewProtocol : DetailViewProtocol!,
         interactorProtocol : DetailInteractorProtocol!) {
        self.viewProtocol = viewProtocol
        self.interactorProtocol = interactorProtocol
    }
}
extension DetailPresenter : DetailPresenterProtocol {
    func doShowVenue(){
        interactorProtocol.doShowVenue()
    }
}
extension DetailPresenter : DetailCallbackProtocol{
    func showVenue(_ venue: Venue!) {
        viewProtocol.showVenue(venue)
    }
    
    
}
