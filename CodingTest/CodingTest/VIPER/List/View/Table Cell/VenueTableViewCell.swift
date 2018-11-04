//
//  VenueTableViewCell.swift
//  CodingTest
//
//  Created by Rickzon Hagos on 31/10/2018.
//  Copyright © 2018 Rickzon. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var venueLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setVenue(_ venue : Venue) {
        venueLbl.text = venue.name
        distanceLbl.text = "\(venue.distance)"
    }
}
