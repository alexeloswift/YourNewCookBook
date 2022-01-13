//
//  MealViewController.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/12/21.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet weak var tableView:   UITableView!
    
    var meal = [Meal]()
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: MealTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MealTableViewCell.identifier)
        
        self.tableView.backgroundColor  = UIColor.systemBackground
        self.tableView.isHidden         = true
        
//        NetworkManager.shared.getMeals(for: category) { [weak self] result in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                
//            case .success(let meals): self.updateUI(with: meals)
//                
//            case .failure(let error): print(error.localizedDescription)
//        }
//    }
}
    
    func updateUI(with subcategory: MealAPIResponse) {
        DispatchQueue.main.async {
            self.meal = subcategory.meals
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }

}

extension MealViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller    = MealDetailsViewController.instantiate()
        let model         = meal[indexPath.row]
        controller.mealID = model.idMeal
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        
//        cell.setup(meal: meal[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
