//
//  enteredEventsTableViewCell.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/13.
//

import UIKit

class enteredEventsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var possibleTimezoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        
        let timezoneStrings : [String] = event.possibleTimezones.map {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM月dd日"
            return "\(formatter.string(from: $0.date)) \($0.from)時〜\($0.to)時"
        }
        possibleTimezoneLabel.text = "候補日:\n\(timezoneStrings.joined(separator: "\n"))"
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        deadlineLabel.text = formatter.string(from: event.deadline)
    }
    
}
