//
//  GrociesVC.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

enum GrocerySections: Int {
    case normal
    case crossed

    static var numberOfSections = 2
}
class GroceriesVC: UIViewController {

    @IBOutlet weak private var tableView: UITableView!

    var groceries: [Grocery] = []
    var crossedOffGroceries: [Grocery] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.tabBarItem = UITabBarItem(title: "Groceries", image: nil, selectedImage: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(groupsButtonPressed))
        tableView.register(UINib(nibName: "GroceryCell", bundle: nil), forCellReuseIdentifier: "GroceryCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchGroceries()
    }

    private func fetchGroceries() {
        Grocery.fetchGroceries { [weak self] (groceries, crossedGroceries, error) in
            guard let self = self else { return }
            if let error = error {
                // present error
            } else {
                self.groceries = groceries
                self.crossedOffGroceries = crossedGroceries
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func groupsButtonPressed() {
        navigationController?.pushViewController(GroupVC(), animated: true)
    }

    @objc func addButtonPressed() {
        navigationController?.pushViewController(AddGroceryVC(), animated: true)
    }
}

extension GroceriesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return GrocerySections.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = GrocerySections.init(rawValue: section) else { return 0 }
        switch section {
        case .normal:
            return groceries.count
        case .crossed:
            return crossedOffGroceries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = GrocerySections.init(rawValue: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryCell") as! GroceryCell
        switch section {
        case .normal:
            cell.configure(grocery: groceries[indexPath.row])
        case .crossed:
            cell.configure(grocery: crossedOffGroceries[indexPath.row])
        }
        return cell
    }

    @objc func deleteCrossedItemsTapped() {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete all crossed items?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { (_) in
            Grocery.batchDelete(crossedGroceries: self.crossedOffGroceries, completionHandler: { (error) in
                if let error = error {
                    // present errror
                } else {
                    self.crossedOffGroceries = []
                    self.tableView.reloadData()
                }
            })
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension GroceriesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groceryCell = tableView.cellForRow(at: indexPath) as? GroceryCell, let grocery = groceryCell.grocery else { return }
        if grocery.status == .normal {
            grocery.status = .crossedOff
            groceries.remove(at: indexPath.row)
            crossedOffGroceries.append(grocery)
        } else {
            grocery.status = .normal
            crossedOffGroceries.remove(at: indexPath.row)
            groceries.append(grocery)
        }
        Network.database.child("Grocery").child(grocery.id).updateChildValues(["status": grocery.status.rawValue])
        tableView.reloadData()

    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let cell = tableView.cellForRow(at: indexPath) as? GroceryCell,
            let grocery = cell.grocery,
            let section = GrocerySections.init(rawValue: indexPath.section) else { return nil }
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            Grocery.delete(grocery: grocery, completionHandler: { (error) in
                if error != nil {
                    // present error
                }
                switch section {
                case .normal:
                    self.groceries.remove(at: indexPath.row)
                case .crossed:
                    self.crossedOffGroceries.remove(at: indexPath.row)
                }
                tableView.reloadData()
            })
        }
        return [delete]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.systemOffWhite
        let label = UILabel()
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.text = "Delete all crossed items"
        label.textColor = UIColor.red

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteCrossedItemsTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = GrocerySections(rawValue: section) else { return 0 }
        switch section {
        case .normal:
            return 0
        case .crossed:
            return crossedOffGroceries.count > 0 ? 30 : 0
        }
    }
}
