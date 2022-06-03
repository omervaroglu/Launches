//
//  AppContainer.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 1.06.2022.
//


import Foundation

/// for application dependency
final class AppContainer {
    
    public static var shared = AppContainer()
    
    let router = AppRouter()
}
