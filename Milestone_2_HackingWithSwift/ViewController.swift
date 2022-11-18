//
//  ViewController.swift
//  Milestone_2_HackingWithSwift
//
//  Created by Igor Guryan on 18.11.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    

    var shoppingList = [String]()
    

    override func viewDidLoad() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptToAddInList))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [addButton, shareButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Empty List", style: .plain, target: self, action: #selector(emptyShoppingList))
        title = "Shopping List"
        super.viewDidLoad()
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func emptyShoppingList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptToAddInList() {
        let ac = UIAlertController(title: "Enter the Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let shoppingItem = ac?.textFields?[0].text else { return }
            self?.submit(shoppingItem)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    


}

