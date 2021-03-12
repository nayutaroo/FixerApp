//
//  confirmedEventsTableViewCell.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/13.
//

import UIKit

class confirmedEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var confirmedTimezoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //(how) overrideできない？？？？
    func configure(event: Event) {
        eventNameLabel.text = event.name
        if let index = event.unenteredUsers.firstIndex(where: { $0.id == event.makerId }){
            creatorNameLabel.text =  event.unenteredUsers[index].name
        }
        else if let index = event.enteredUsers.firstIndex(where: { $0.id == event.makerId }){
            creatorNameLabel.text =  event.enteredUsers[index].name
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日"
        if let decidedTimezone =  event.decidedTimezone {
            confirmedTimezoneLabel.text =  "確定時間:\n\(formatter.string(from: decidedTimezone.date)) \(decidedTimezone.from)時〜\(decidedTimezone.to)時"
        }
    }
    
}
