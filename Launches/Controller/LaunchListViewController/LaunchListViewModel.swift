//
//  LaunchListViewModel.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 1.06.2022.
//

import Foundation
import Apollo

final class LaunchListViewModel: LaunchListProtocol {

    var delegate: LaunchListViewModelDelegate?
    var launches: [LaunchListQuery.Data.LaunchesPast?] = []
    var moreLunches: [LaunchListQuery.Data.LaunchesPast?] = []
    var limit = 20
    var offset = 0
    
    func loadDatas() {
        notify(.titleUpdate("Launches"))
        Network.shared.apollo.fetch(query: LaunchListQuery(limit: limit)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                print(result)
                self.launches = result.data?.launchesPast ?? []
                self.notify(.showLaunches)
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
    
    func loadMoreData() {
        /// server data check for unnecessary request
        if offset > limit && self.moreLunches.isEmpty { return }
        
        offset += limit
        
        Network.shared.apollo.fetch(query: LaunchListQuery(limit: limit, offset: offset)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.moreLunches = result.data?.launchesPast ?? []
                self.notify(.showMore)
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    func selectItem(at Id: GraphQLID?) {
        let viewModel = LaunchDetailViewModel(launchId: Id)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    private func notify(_ output: LaunchListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
