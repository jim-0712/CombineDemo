//
//  APIDemoViewController.swift
//  CombineDemo
//
//  Created by Fu Jim on 2021/3/2.
//

import UIKit
import Combine

class APIDemoViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel = UserViewModel()
    private var subscribetion = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.fetchUser()
    }
    
    private
    func setupView() {
        self.view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private
    func bindViewModel() {
        viewModel.usersSubjects
            .sink(receiveCompletion: { print($0) },
                                     receiveValue: {
                                        self.viewModel.users = $0
                                        self.tableView.reloadData()
                                     })
            .store(in: &subscribetion)
    }
}

extension APIDemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = viewModel.users[indexPath.row].name
        cell.detailTextLabel?.text = viewModel.users[indexPath.row].company.name
        return cell
    }
}
