//
//  ViewController.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/12/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemsArray = ["Learn More Swift!", "Call Mom", "XMas Gifts"]
    
    let toDoListKey = "ToDoListArray"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = defaults.array(forKey: toDoListKey) as? [String] {
            itemsArray = items
        }
    }

    // MARK: - TableView Datasouce Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            if let newToDo = alert.textFields?.first?.text {
                self.itemsArray.append(newToDo)
                
                self.defaults.set(self.itemsArray, forKey: self.toDoListKey)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

