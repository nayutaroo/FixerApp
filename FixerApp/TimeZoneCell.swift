//
//  TimeZoneCell.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/01/23.
//

import UIKit

enum TimeZoneStatus{
    
 case available
 case undecided
 case unavailable
    
    func color() ->UIColor{
        switch self{
        case .available:
            return .red
        case .undecided:
            return .green
        case .unavailable:
            return .blue
        }
    }
}

class TimeZoneCell: UICollectionViewCell {
    @IBOutlet weak var timezoneLabel: UILabel!
    var status: TimeZoneStatus = .unavailable
    
//    init(status: Status){
//        self.status = status
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
