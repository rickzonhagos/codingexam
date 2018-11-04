//
//  ListViewProtocol.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

protocol ListViewProtocol: class {
    func showVenueList(_ list : [Venue]!)
    func showErrorMsg(_ msg : String!)
}
