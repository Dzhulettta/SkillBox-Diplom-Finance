//
//  HistoryTableViewCell.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 26.12.2020.
//

import UIKit
import CoreData
import CoreImage

class HistoryTableViewCell: UITableViewCell {
    var copyCoreDataHistory = CoreDataHistory()

    @IBOutlet weak var imageHistory: UIImageView!
    @IBOutlet weak var labelHistory: UILabel!
    @IBOutlet weak var sumHistory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.copyCoreDataHistory.appToCoreDate()
       
    }
    func initCell(item: NSManagedObject){
        
        let sumString = item.value(forKey: "sum") as? String
        let price = (sumString as! NSString).integerValue
        sumHistory.text = "\(price)₽"
        
        labelHistory.text = item.value(forKey: "label") as? String
        
        
        let imageString = item.value(forKey: "image") as! String
        print("Картинка ну ка: \(imageString)")
     

    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){

        //dismissViewControllerAnimated(true, completion: nil)

        let newImageData = image.jpegData(compressionQuality: 1)
        let myImageFromData = UIImage(data: newImageData!)
        print("Что-нибудь: \(myImageFromData)")
    }

   
    
//    func getImage(from string: String) -> UIImage? {
//        guard let url = URL(string: string)
//        else {
//            print("Unable to create URL")
//            return nil
//        }
//        var image: UIImage? = nil
//        do {
//            let data = try Data(contentsOf: url, options: [])
//            image = UIImage(data: data)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//        return image
//    }
    
}
