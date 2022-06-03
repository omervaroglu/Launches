//
//  LaunchDetailBuilder.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import Foundation
import UIKit

class LaunchDetailBuilder {
    
    static func make(with viewModel: LaunchDetailProtocols) -> LaunchDetailViewController {
        let storyboard = UIStoryboard(name: "LaunchDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchDetailViewController") as! LaunchDetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
}
