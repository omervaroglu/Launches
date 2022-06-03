//
//  LaunchListBuilder.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 1.06.2022.
//

import Foundation
import UIKit

class LaunchListBuilder {
    
    static func make() -> LaunchListViewController {
        let storyboard = UIStoryboard(name: "LaunchList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchListViewController") as! LaunchListViewController
        viewController.viewModel = LaunchListViewModel()
        return viewController
    }
    
}
