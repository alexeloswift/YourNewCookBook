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
    
    static let identifier = "MealTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(meal: Meal) {
        mealTitleLabel.text = meal.strMeal
        downloadImage(fromURL: meal.strMealThumb)
    }
    override func prepareForReuse() {
        mealImageView.image = nil
        mealTitleLabel.text = ""
    }
    func downloadImage(fromURL url: String) {
        APICaller.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mealImageView.image = image
            }
        }
    }
}
