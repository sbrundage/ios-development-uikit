//
//  ViewController.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/12/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var itemTitle: UINavigationItem!
    
    var todoItems: Results<ToDoItem>?
    var longPress = UILongPressGestureRecognizer()
    
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    let toDoListKey = "ToDoListArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(ToDoListViewController.handleLongPress))
        tableView.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let colorHex = selectedCategory?.colorString {
            
            itemTitle.title = selectedCategory!.name + " To Do"
            
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller doesn't exist") }
            
            if let navBarColor = UIColor(hexString: colorHex) {
                navBar.barTintColor = navBarColor
                navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
                searchBar.barTintColor = navBarColor
            }
        }
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

            if let color =  UIColor(hexString: selectedCategory!.colorString)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            
            
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
                        if let toDoItemName = alert.textFields?.first?.text {
                            if toDoItemName != "" {
                                let newToDo = ToDoItem()
                                newToDo.title = toDoItemName
                                newToDo.dateCreated = Date()
                                
                                // Grab second text field input
                                if let itemInfo = alert.textFields?[1].text {
                                    newToDo.info = itemInfo
                                }
                                
                                currentCategory.items.append(newToDo)
                                
                                self.realm.add(newToDo)
                            }
                        }
                    }
                } catch {
                    print("Error saving ToDoItem to Realm: \(error)")
                }
            }
            self.reloadTableView()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "To Do Item Title"
        }
                
        alert.addTextField { (alertTextFeld) in
            alertTextFeld.placeholder = "Additional Info"
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
    
    private func infoPopUp(infoString: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "More Info", message: infoString, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completionHandler() // This will only get called after okay is tapped in the alert
        }

        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if longPress.state == UIGestureRecognizer.State.began {
            let touchPoint = longPress.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                if let itemInfo = todoItems?[indexPath.row].info {
                    if itemInfo != "" {
                        infoPopUp(infoString: itemInfo) {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
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

