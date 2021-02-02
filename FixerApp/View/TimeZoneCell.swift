//
//  TimeZoneCell.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/23.
//

import UIKit

enum TimeZoneStatus : Int {
    
 case available
 case undecided
 case unavailable
 case undefined
    
    func color() -> UIColor {
        switch self {
        case .available:
            return .red
        case .undecided:
            return .green
        case .unavailable:
            return .blue
        case .undefined:
            return .gray
        }
        
    }
}

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
