//
//  LaunchDetailProtocols.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol LaunchDetailProtocols{
    var delegate: LaunchDetailViewModelDelegate? {get set}
    var launch: BehaviorRelay<LaunchQuery.Data.Launch?> {get set}
    func loadDatas()
}

enum LaunchDetailViewModelOutput {
    case titleUpdate(String)
    case showDetail
}

protocol LaunchDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LaunchDetailViewModelOutput)
}
