//
//  GrociesVC.swift
//  GroceryApp
//
//  Created by Jonathan on 7/22/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class GroceriesVC: UIViewController {
    
    @IBOutlet weak private var addButton: UIBarButtonItem!
    @IBOutlet weak private var filterButton: UIBarButtonItem!
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GroceryCell", bundle: nil), forCellReuseIdentifier: "GroceryCell")
        self.tableView.dataSource = self
        self.filterButton.target = self
        self.filterButton.action = #selector(filterButtonPressed)
    }
    
    @objc func filterButtonPressed() {
        self.navigationController?.present(GroupVC(), animated: true, completion: nil)
        
    }
}

extension GroceriesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Grocery.testGroceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "GroceryCell") as! GroceryCell
        cell.configure(grocery: Grocery.testGroceries[indexPath.row])
        return cell
    }
    
}
