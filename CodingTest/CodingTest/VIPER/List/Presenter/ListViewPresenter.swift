//
//  ListViewPresenter.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

class ListViewPresenter: NSObject {
    public private(set) weak var viewProtocol : ListViewProtocol!
    public private(set) var interactorProtocol : ListViewInteractorProtocol!
    public private(set) var router : ListViewRouter!
    
    init(withViewProtocol viewProtocol : ListViewProtocol!,
         interactorProtocol : ListViewInteractorProtocol!,
         router : ListViewRouter!) {
        self.viewProtocol = viewProtocol
        self.interactorProtocol = interactorProtocol
        self.router = router
    }
}


extension ListViewPresenter : ListViewPresenterProtocol {
    func navigateToDetailsPage(_ venue: Venue) {
        self.router.navigateToDetailsPage(viewProtocol as! UIViewController, venue: venue)
    }
    
    
    func doSearchVenues(withLongitude longitude : String!, latitude : String!){
        
        self.interactorProtocol.doSearchVenues(withLongitude: longitude, latitude:latitude, successResult: { [weak weakSelf = self](venueList) in
            guard let weakSelf = weakSelf else {
                return
            }
            weakSelf.viewProtocol.showVenueList(venueList)
            
        }, failureResult : {
            [weak weakSelf = self](errorMsg) in
            guard let weakSelf = weakSelf else {
                return
            }
            weakSelf.viewProtocol.showErrorMsg(errorMsg)
        })
    }
}
extension ListViewPresenter : ListViewCallbackProtocol {
    
}
