//
//  ChooseCategoriesTableViewCell.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 01.12.2020.
//

import UIKit
import CoreData

class ChooseCategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    var numberImage: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    func initCell(item: NSManagedObject){
        let image = item.value(forKey: "image") as! String
        let name = item.value(forKey: "name") as! String
        categoryLabel.text = "\(name)"
        let used = item.value(forKey: "used") as? Bool
        if used == false{
            checkmark.image = UIImage(named: "checkin")
        } else {
            checkmark.image = UIImage(named: "check")
        }
    }
}
