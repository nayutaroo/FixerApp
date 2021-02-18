//
//  TimeZoneCell.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/23.
//

import UIKit

class TimeZoneCell: UICollectionViewCell {
    @IBOutlet weak var timezoneLabel: UILabel!
    var status: TimeZoneStatus = .unavailable
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        status = .unavailable
    }
}
