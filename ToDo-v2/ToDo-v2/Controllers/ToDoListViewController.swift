//
//  ViewController.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/12/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: SwipeTableViewController {
    
    @IBOutlet weak var categoryNavigationItem: UINavigationItem!
    
    
    var todoItems: Results<ToDoItem>?
    
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    let toDoListKey = "ToDoListArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        categoryNavigationItem.title = selectedCategory!.name + " To Do"
    }

    // MARK: - TableView Datasouce Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving 'done' status: \(error)")
            }
        }
        
        reloadTableView()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newToDo = ToDoItem()
                        newToDo.title = alert.textFields?.first?.text ?? ""
                        newToDo.dateCreated = Date()
                        currentCategory.items.append(newToDo)
                        
                        self.realm.add(newToDo)
                    }
                } catch {
                    print("Error saving ToDoItem to Realm: \(error)")
                }
            }
            self.reloadTableView()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {

        // Load items by alpha order
//        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        // Load items by date created
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)

        reloadTableView()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemForDeletion = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleting to do item: \(error)")
            }
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

