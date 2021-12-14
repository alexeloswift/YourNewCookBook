//
//  ViewController.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/11/21.
//

import UIKit



class MealDetailsViewController: UIViewController {

    @IBOutlet weak var detailImageView:     UIImageView!
    @IBOutlet weak var detailTitleLabel:    UILabel!
    @IBOutlet weak var instructionsLabel:   UILabel!
    @IBOutlet weak var ingredientsLabel:    UILabel!
    
   
    
    var item = [MealDetails]()
    
    var mealID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title                      = "Recipe"
       
        
        self.detailImageView.isHidden   = true
        self.detailTitleLabel.isHidden  = true
        self.instructionsLabel.isHidden = true
        self.ingredientsLabel.isHidden  = true
        
        detailTitleLabel.numberOfLines  = 0
        instructionsLabel.numberOfLines = 0
        ingredientsLabel.numberOfLines  = 0
        
        detailImageView.layer.cornerRadius  = 10
        detailImageView.clipsToBounds       = true

        APICaller.shared.getMealDetails(for: mealID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let meal):
                self.addMealInfo(meal: meal)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addMealInfo(meal: MealDetailsAPIResponse) {
        DispatchQueue.main.async {
            self.item                   = meal.meals
            self.detailTitleLabel.text  = self.item.first?.strMeal
            self.instructionsLabel.text = "Instructions: \(self.item.first?.strInstructions ?? "")"
            self.downloadImage(fromURL: self.item.first?.strMealThumb ?? "missing")
            
            var getIngredients =
                """
                Ingredients:
                \(self.item.first?.strIngredient1 ?? "") \(self.item.first?.strMeasure1 ?? ""), \
                \(self.item.first?.strIngredient2 ?? "") \(self.item.first?.strMeasure2 ?? ""), \
                \(self.item.first?.strIngredient3 ?? "") \(self.item.first?.strMeasure3 ?? ""), \
                \(self.item.first?.strIngredient4 ?? "") \(self.item.first?.strMeasure4 ?? ""), \
                \(self.item.first?.strIngredient5 ?? "") \(self.item.first?.strMeasure5 ?? ""), \
                \(self.item.first?.strIngredient6 ?? "") \(self.item.first?.strMeasure6 ?? ""), \
                \(self.item.first?.strIngredient7 ?? "") \(self.item.first?.strMeasure7 ?? ""), \
                \(self.item.first?.strIngredient8 ?? "") \(self.item.first?.strMeasure8 ?? ""), \
                \(self.item.first?.strIngredient9 ?? "") \(self.item.first?.strMeasure9 ?? ""), \
                \(self.item.first?.strIngredient10 ?? "") \(self.item.first?.strMeasure10 ?? ""), \
                \(self.item.first?.strIngredient11 ?? "") \(self.item.first?.strMeasure11 ?? ""), \
                \(self.item.first?.strIngredient12 ?? "") \(self.item.first?.strMeasure12 ?? ""), \
                \(self.item.first?.strIngredient13 ?? "") \(self.item.first?.strMeasure13 ?? ""), \
                \(self.item.first?.strIngredient14 ?? "") \(self.item.first?.strMeasure14 ?? ""), \
                \(self.item.first?.strIngredient15 ?? "") \(self.item.first?.strMeasure15 ?? ""), \
                \(self.item.first?.strIngredient16 ?? "") \(self.item.first?.strMeasure16 ?? ""), \
                \(self.item.first?.strIngredient17 ?? "") \(self.item.first?.strMeasure17 ?? ""), \
                \(self.item.first?.strIngredient18 ?? "") \(self.item.first?.strMeasure18 ?? ""), \
                \(self.item.first?.strIngredient19 ?? "") \(self.item.first?.strMeasure19 ?? ""), \
                \(self.item.first?.strIngredient20 ?? "") \(self.item.first?.strMeasure20 ?? "")
                """.replacingOccurrences(of: " ,", with: "").trimmingCharacters(in: .whitespacesAndNewlines)

            if getIngredients.last == "," {
                _ = getIngredients.popLast()
            }
            self.ingredientsLabel.text = getIngredients + "."
            
            self.detailImageView.isHidden = false
            self.detailTitleLabel.isHidden = false
            self.instructionsLabel.isHidden = false
            self.ingredientsLabel.isHidden = false
        }
    }
    
    func downloadImage(fromURL url: String) {
        APICaller.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.detailImageView.image = image
            }
        }
    }
    

    
    
}
