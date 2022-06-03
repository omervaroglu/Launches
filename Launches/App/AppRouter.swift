//
//  AppRouter.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 1.06.2022.
//

import UIKit

final class AppRouter {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }

    func start(){
        let viewController = LaunchListBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
