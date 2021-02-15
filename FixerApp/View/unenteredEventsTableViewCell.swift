//
//  unenteredEventsTableViewCell.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/13.
//

import UIKit

class unenteredEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
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
            creatorNameLabel.text = "作成者: \(event.unenteredUsers[index].name)"
        }
        else if let index = event.enteredUsers.firstIndex(where: { $0.id == event.makerId }){
            creatorNameLabel.text = "作成者: \(event.enteredUsers[index].name)"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 MM月 dd日 HH:mm"
        deadlineLabel.text = "期限: \(formatter.string(from: event.deadline))"
    }
    
}
