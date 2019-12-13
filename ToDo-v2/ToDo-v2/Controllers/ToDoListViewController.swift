//
//  ViewController.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/12/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemsArray: [ToDoItem] = []
    
    let toDoListKey = "ToDoListArray"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = ToDoItem()
        newItem.title = "Learn More Swift!"
        itemsArray.append(newItem)
        
        let newItem2 = ToDoItem()
        newItem2.title = "Call Mom"
        itemsArray.append(newItem2)
        
        let newItem3 = ToDoItem()
        newItem3.title = "Buy Xmas Gifts"
        itemsArray.append(newItem3)
        
//        if let items = defaults.array(forKey: toDoListKey) as? [String] {
//            itemsArray = items
//        }
    }

    // MARK: - TableView Datasouce Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            let newToDo = ToDoItem()
            newToDo.title = alert.textFields?.first?.text ?? ""
            
            self.itemsArray.append(newToDo)
            
            self.defaults.set(self.itemsArray, forKey: self.toDoListKey)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

