//
//  LaunchListViewController.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 1.06.2022.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxCocoa

typealias UserDataSource = UITableViewDiffableDataSource<LaunchListViewController.Section, LaunchListQuery.Data.LaunchesPast?>
typealias UserSnapshot = NSDiffableDataSourceSnapshot<LaunchListViewController.Section, LaunchListQuery.Data.LaunchesPast?>

class LaunchListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: LaunchListViewModel! {
        didSet{
            viewModel.delegate = self
        }
    }
    private var dataSource: UserDataSource!
    var snapshot = UserSnapshot()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadDatas()
        registerTableView()
        bindTableView()
        configureDataSource()
        
    }
    
    private func registerTableView() {
        tableView.delegate = self
    }
    
    private func configureDataSource(){
        tableView.registerCells([LaunchTableViewCell.self])
        dataSource = UserDataSource(tableView: tableView, cellProvider: { tableView, indexPath, launch in
            let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as! LaunchTableViewCell
            let launch = self.viewModel.launches[indexPath.row]
            cell.setUI(image: launch?.links?.missionPatchSmall, launchName: launch?.missionName, rocketName: launch?.rocket?.rocketName)
            return cell
            })
    }
    
    private func createSnapshot() {
        snapshot.appendSections([.first])
        snapshot.appendItems(viewModel.launches, toSection: .first)
        dataSource.applySnapshotUsingReloadData(snapshot)
    }

    private func addMoreData(){
        let listCount = viewModel.launches.count - 1
        snapshot.insertItems(viewModel.moreLunches, afterItem: viewModel.launches[listCount])
        dataSource.applySnapshotUsingReloadData(snapshot)
        viewModel.launches.append(contentsOf: viewModel.moreLunches.compactMap{ $0 } )
    }
    
    private func bindTableView(){
        tableView.rx.willDisplayCell.subscribe { [weak self] item in
            guard let self = self else { return }
            if item.element?.indexPath.row == self.viewModel.launches.count - 20 {
                self.viewModel.loadMoreData()
            }
        }.disposed(by: bag)
    }
}

//MARK: - LaunchListViewModelDelegate
extension LaunchListViewController: LaunchListViewModelDelegate {
    func handleViewModelOutput(_ output: LaunchListViewModelOutput) {
        switch output {
        case .titleUpdate(let title):
            self.title = title
        case .showLaunches:
            createSnapshot()
        case .showMore:
            addMoreData()
        }
    }
    
    func navigate(to route: LaunchListRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = LaunchDetailBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
}
//MARK: - TableViewDelegate
extension LaunchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: viewModel.launches[indexPath.row]?.id)
    }
}

extension LaunchListViewController {
    enum Section: Int{
        case first
    }
}

/// I create some extension for using apollo model in diffable data source
/// because apollo team do not publish yet - https://github.com/apollographql/apollo-ios/issues/442 - still prerelase
extension LaunchListQuery.Data.LaunchesPast: Equatable {
    public static func == (lhs: LaunchListQuery.Data.LaunchesPast, rhs: LaunchListQuery.Data.LaunchesPast) -> Bool {
        return lhs.id == rhs.id
    }
}
extension LaunchListQuery.Data.LaunchesPast: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
