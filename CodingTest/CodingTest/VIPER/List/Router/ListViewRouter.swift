//
//  ListViewRouter.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 29/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

class ListViewRouter: NSObject {
    func navigateToDetailsPage(_ presentor : UIViewController, venue : Venue) {
        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        let interactor = DetailInteractor()
        let presenter = DetailPresenter(withViewProtocol: detailViewController, interactorProtocol: interactor)
        interactor.callBackProtocol = presenter
        interactor.venue = venue
        detailViewController.presenter = presenter
        presentor.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
