//
//  LaunchTableViewCell.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet private weak var launchImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var secondaryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func setUI(image: String?, launchName: String?, rocketName: String?) {
        self.titleLabel.text = launchName ?? ""
        self.secondaryLabel.text = rocketName
        setImg(image: self.launchImageView, imgLink: image ?? "")
    }
}
