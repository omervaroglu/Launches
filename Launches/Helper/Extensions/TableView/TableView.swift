//
//  TableView.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import Foundation
import UIKit

extension UITableView {
    func register(with commonId: String) {
        register(UINib(nibName: commonId, bundle: nil), forCellReuseIdentifier: commonId)
    }
    
    func registerCells(_ cells: [UITableViewCell.Type]) {
        for cell in cells {
            register(nibFromClass(cell), forCellReuseIdentifier: cell.nameOfClass)
        }
    }
    
    fileprivate func nibFromClass(_ type: UIView.Type) -> UINib {
        return UINib(nibName: type.nameOfClass, bundle: nil)
    }
}
