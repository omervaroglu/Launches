//
//  LaunchDetailViewController.swift
//  Launches
//
//  Created by Ömer Faruk Varoğlu on 2.06.2022.
//

import Foundation
import UIKit
import Apollo
import RxSwift
import RxCocoa

class LaunchDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: LaunchDetailProtocols!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadDatas()
        registerTableView()
    }

    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells([LaunchImageTableViewCell.self])
    }
    
}
//MARK: - LaunchListViewModelDelegate
extension LaunchDetailViewController: LaunchDetailViewModelDelegate {
    
    func handleViewModelOutput(_ output: LaunchDetailViewModelOutput) {
        switch output {
        case .titleUpdate(let title):
            self.title = title
        case .showDetail:
            tableView.reloadData()
        }
    }
    
}
extension LaunchDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchImageTableViewCell", for: indexPath) as! LaunchImageTableViewCell
            setImg(image: cell.LaunchImageView, imgLink: viewModel.launch.value?.links?.missionPatch ?? "")

            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = (viewModel.launch.value?.launchSuccess ?? false) ? "Launch successfully completed." : "Launch could not be completed."
            content.textProperties.color = (viewModel.launch.value?.launchSuccess ?? false) ? UIColor.systemGreen : UIColor.red
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = viewModel.launch.value?.rocket?.rocketName ?? ""
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = viewModel.launch.value?.details ?? "There is no more details"
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Success Status"
        case 2:
            return "Rocket Name"
        case 3:
            return "Details"
        default:
            return ""
        }
    }
}
