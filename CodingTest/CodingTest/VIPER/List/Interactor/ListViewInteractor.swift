//
//  ListViewInteractor.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit
import FoursquareAPIClient
class ListViewInteractor: NSObject {
    public var callBackHandler : ListViewCallbackProtocol!
    
}
extension ListViewInteractor : ListViewInteractorProtocol {
    
    
    func doSearchVenues(withLongitude longitude : String!, latitude : String!, successResult : @escaping ([Venue]) -> Void, failureResult : @escaping (String)-> Void ){
        
        let client = FoursquareAPIClient(clientId: Constants.ClientID, clientSecret: Constants.ClientSecret)
        let parameter: [String: String] = [
            "ll": "\(latitude!),\(longitude!)",
            "limit": "10",
            ];
        client.request(path: "venues/search", parameter: parameter) { result in
            switch result {
            case let .success(data):
                
                do {
                    if let json = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                        let response = json.object(forKey: "response") as? NSDictionary,
                        let venues = response.object(forKey: "venues") as? [NSDictionary]{
                        
                        var venueList : [Venue] = [Venue]()
                        
                        for venueItem in venues {
                            let name =  venueItem.value(forKey: "name") as? String
                            
                            var address : String?
                            var distance : Int = 0
                            if let location = venueItem.object(forKey:"location") as? NSDictionary {
                                if let formattedAddress = location.object(forKey: "formattedAddress") as? [String] {
                                    for addressItem in formattedAddress {
                                        if let _ = address{
                                            address = "\(address!) \(addressItem)"
                                        }else {
                                            address = addressItem
                                        }
                                    }
                                }
                                distance =  location.object(forKey: "distance") as! Int
                            }
                            
                            let venue = Venue(name: name, distance: distance, address: address)
                            venueList.append(venue)
                        }
                        successResult(venueList)
                    }
                }
                catch let error {
                    print(error.localizedDescription)
                }
                
            case let .failure(error):
                // Error handling
                switch error {
                case let .connectionError(connectionError):
                    print(connectionError)
                    failureResult(connectionError as! String)
                case let .responseParseError(responseParseError):
                    print(responseParseError)
                    failureResult(responseParseError as! String)
                case let .apiError(apiError):
                    print(apiError.errorType)
                    print(apiError.errorDetail)
                    failureResult(apiError.errorDetail)
                }
            }
        }
    }
}

