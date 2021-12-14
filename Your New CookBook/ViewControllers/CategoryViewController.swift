//
//  CategoryViewController.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/12/21.
//

import Foundation
import UIKit




class CategoryViewController: UIViewController {

    @IBOutlet var tableView:   UITableView!
   
    
    var category = [Category]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: CategoryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        self.tableView.backgroundColor  = UIColor.systemBackground
        self.tableView.isHidden         = true
        
       
        
        
        
        APICaller.shared.getCategories() { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.updateUI(with: categories)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateUI(with categories: CategoryAPIResponse) {
        DispatchQueue.main.async {
            self.category = categories.categories
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller      = MealViewController.instantiate()
        let model           = category[indexPath.row]
        controller.category = model.strCategory
        controller.title    = model.strCategory + " list"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        category.sort{ $0.strCategory < $1.strCategory }
        
        cell.setup(category: category[indexPath.row])
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
}


