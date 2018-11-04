//
//  DetailInteractor.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 04/11/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

class DetailInteractor: NSObject {
    var venue : Venue!
    weak var callBackProtocol : DetailCallbackProtocol!
}
extension DetailInteractor : DetailInteractorProtocol {
    func doShowVenue() {
        callBackProtocol.showVenue(venue)
    }
}
