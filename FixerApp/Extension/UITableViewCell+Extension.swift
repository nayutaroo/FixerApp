//
//  UITableViewCell+Extension.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/13.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}
