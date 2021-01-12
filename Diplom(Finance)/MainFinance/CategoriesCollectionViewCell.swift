//
//  CategoriesCollectionViewCell.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 30.11.2020.
//

import UIKit
import CoreData

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var labelCategory: UILabel!
    var numberImage: String!
    
    func initCell(item: NSManagedObject){
        var copyChooseCategoriesCoreData = ChooseCategoriesCoreData()
        numberImage = item.value(forKey: "image") as! String
            labelCategory.text = item.value(forKey: "name") as! String
    imageCategory.image = UIImage(named: "\(numberImage!)")
    }
}
