//
//  ListViewPresenterProtocol.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

protocol ListViewPresenterProtocol: class {
    func doSearchVenues(withLongitude longitude : String!, latitude : String!)
    func navigateToDetailsPage(_ venue: Venue)
}
