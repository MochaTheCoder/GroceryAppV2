//
//  FilterVC.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var groups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroup))

        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Group.fetchGroups { (groups, error) in
            if let error = error {
                self.present(error: error)
            } else {
                self.groups = groups
                self.tableView.reloadData()
            }
        }
    }

    @objc private func addGroup() {
        navigationController?.pushViewController(AddGroupVC(), animated: true)
    }
}

extension GroupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "default")
        cell.textLabel?.text = groups[indexPath.row].name ?? ""
        return cell
    }

}
