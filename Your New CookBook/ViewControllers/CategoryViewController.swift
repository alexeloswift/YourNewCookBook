//
//  CategoryViewController.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/12/21.
//

import UIKit


class CategoryViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
    }

    @IBOutlet var tableView:   UITableView!
   
    var category = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
        
        let nib = UINib(nibName: CategoryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        self.tableView.backgroundColor  = UIColor.systemBackground
        self.tableView.isHidden         = true
        
//        NetworkManagerWithGenerics.shared.getCategories() { [weak self] result in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                
//            case .success(let categories):
//                self.updateUI(with: categories)
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func updateUI(with categories: CategoryAPIResponse) {
        
        DispatchQueue.main.async {
            
            self.category = categories.categories
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    private func getCategories() {
       
        Task {
            do {
                let response: CategoryAPIResponse = try await NetworkManagerWithGenerics.shared.getRequest(endpoint: .categories())
                updateUI(with: response)
              
            } catch {
                print("Hi")
//                if let ncError = error as? ErrorMessages {
//                    presentNMAlert(title: "Something went wrong", message: ErrorMessages.rawValue, buttonTitle: "Ok")
//                } else {
//                    presentNMAlert(title: "Something went wrong", message: "Unable to complete task at this time. Please try again.", buttonTitle: "Ok")
                }
                
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


