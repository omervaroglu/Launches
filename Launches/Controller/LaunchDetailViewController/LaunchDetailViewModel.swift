//
//  LaunchDetailViewModel.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import Foundation
import Apollo
import RxSwift
import RxCocoa
import RxApolloClient

final class LaunchDetailViewModel: LaunchDetailProtocols {
    
    var delegate: LaunchDetailViewModelDelegate?
    
    private var launchId = GraphQLID()
    var launch = BehaviorRelay<LaunchQuery.Data.Launch?>(value: nil)
    
    init(launchId: GraphQLID?) {
        self.launchId = launchId ?? GraphQLID()
    }
    
    func loadDatas() {
        Network.shared.apollo.fetch(query: LaunchQuery(launchId: launchId)){ result in
            switch result {
            case .success(let result):
                self.notify(.titleUpdate(result.data?.launch?.missionName ?? ""))
                print(result)
                self.launch.accept(result.data?.launch)
                self.notify(.showDetail)
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
    
    private func notify(_ output: LaunchDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
