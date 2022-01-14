//
//  CategoryTableViewCell.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/12/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView:   UIImageView!
    @IBOutlet weak var categoryTitleLabel:  UILabel!
    
    //   FOR STORYBOARD VC
    
    static let identifier = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // @STATE OF CELL IN IB
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
    //    INTIALIZING CELL
    
    func setup(category: Category) {
        categoryTitleLabel.text = category.strCategory
        downloadImage(fromURL: category.strCategoryThumb)
    }
    
    //    SETTING INTIAL STATE OF A REUSED CELL
    
    override func prepareForReuse() {
        categoryImageView.image = nil
        categoryTitleLabel.text = ""
    }
    
    //    GET IMAGE FROM URL FOR CELL
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.categoryImageView.image = image
            }
        }
    }
}
