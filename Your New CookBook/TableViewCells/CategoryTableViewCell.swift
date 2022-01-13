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
    
    static let identifier = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(category: Category) {
        categoryTitleLabel.text = category.strCategory
        downloadImage(fromURL: category.strCategoryThumb)
    }
    override func prepareForReuse() {
        categoryImageView.image = nil
        categoryTitleLabel.text = ""
    }
    func downloadImage(fromURL url: String) {
//        NetworkManagerWithGenerics.shared.downloadImage(from: url) { [weak self] image in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.categoryImageView.image = image
//            }
//        }
    }
}
