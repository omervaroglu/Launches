//
//  LaunchListProtocols.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 1.06.2022.
//

import Foundation
import Apollo

protocol LaunchListProtocol{
    var delegate: LaunchListViewModelDelegate? {get set}
    
    func loadDatas()
    func loadMoreData()
    func selectItem(at Id: GraphQLID?)
}

enum LaunchListViewModelOutput {
    case titleUpdate(String)
    case showLaunches
    case showMore
}

enum LaunchListRoute{
    case detail(LaunchDetailProtocols)
}

protocol LaunchListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LaunchListViewModelOutput)
    func navigate(to route: LaunchListRoute)
}
