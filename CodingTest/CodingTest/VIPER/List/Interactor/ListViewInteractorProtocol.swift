//
//  ListViewInteractorProtocol.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

protocol ListViewInteractorProtocol: class {
    func doSearchVenues(withLongitude longitude : String!, latitude : String!, successResult : @escaping ([Venue]) -> Void, failureResult : @escaping (String)-> Void )
}
