//
//  MealTableViewCell.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/12/21.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    
    //   FOR STORYBOARD VC
    
    static let identifier = "MealTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // @STATE OF CELL IN IB
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //    INTIALIZING CELL
    
    func setup(meal: Meal) {
        mealTitleLabel.text = meal.strMeal
        downloadImage(fromURL: meal.strMealThumb)
    }
    //    SETTING INTIAL STATE OF A REUSED CELL
    
    override func prepareForReuse() {
        mealImageView.image = nil
        mealTitleLabel.text = ""
    }
    
    //    GET IMAGE FROM URL FOR CELL
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mealImageView.image = image
            }
        }
    }
}
