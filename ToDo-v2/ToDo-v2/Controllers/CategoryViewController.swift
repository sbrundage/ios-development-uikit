//
//  CategoryViewController.swift
//  ToDo-v2
//
//  Created by Stephen Brundage on 12/14/19.
//  Copyright © 2019 Stephen Brundage. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")
        }

        navBar.barTintColor = UIColor(hexString: "#1D9BF6")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.colorString) else { fatalError() }
            cell.backgroundColor = UIColor(hexString: category.colorString)
//            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: categoryColor), returnFlat: true)
        } else {
            cell.textLabel?.text = "No categories added yet..."
        }
        
        return cell
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
        
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New To Do Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            
            if let categoryName = alert.textFields?.first?.text {
                if categoryName != "" {
                    newCategory.name = categoryName
                    newCategory.colorString = UIColor.randomFlat().hexValue()
                    self.saveCategories(category: newCategory)
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods
    func saveCategories(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving to category to Realm: \(error)")
        }
        
        reloadTableView()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        
        reloadTableView()
    }
    
    // MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category: \(error)")
            }
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
