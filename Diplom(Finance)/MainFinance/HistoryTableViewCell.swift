//
//  HistoryTableViewCell.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 26.12.2020.
//

import UIKit
import CoreData
//import CoreImage

class HistoryTableViewCell: UITableViewCell {
    
    var copyCoreDataHistory = CoreDataHistory()
    
    @IBOutlet weak var imageHistory: UIImageView!
    @IBOutlet weak var labelHistory: UILabel!
    @IBOutlet weak var sumHistory: UILabel!
    @IBOutlet weak var data: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.copyCoreDataHistory.appToCoreDate()
        
    }
    func initCell(item: NSManagedObject){
        copyCoreDataHistory.appToCoreDate()
        if copyCoreDataHistory.coreDataHistory.count != 0 {
           
            let sumString = item.value(forKey: "sum") as? String
            let price = (sumString as! NSString).integerValue
            sumHistory.text = "\(price)₽"
            let dataString = item.value(forKey: "data") as? String
              let labelHistoryString = (item.value(forKey: "label") as! String) as! String
            labelHistory.text = labelHistoryString
            let imageString = ((item.value(forKey: "image") as! String) as! NSString).integerValue

            imageHistory.image = UIImage(named: "\(imageString)")
            print("Картинка ну ка2: \(imageString)")
            print("Картинка ну ка3: \(labelHistoryString)")
//        }
     
        
            
            
            
            
//        labelHistory.text = "\(item.value(forKey: "label") as! String)"
//        let imageString = item.value(forKey: "image") as? String
//        if let imageString = item.value(forKey: "image") as? String, let image = UIImage(named: imageString){
//            imageHistory.image = image
//
            
            
            
            
//            imageHistory.image = UIImage(named: "\(imageString)")
         //   print("Картинка ну ка2: \(imageString)")
//        }
            data.text = "\(dataString!)"
            print("dataaaa: \(dataString!)")
            print("Картинка ну ка3: \(item.value(forKey: "label") as! String)")
        print("Картинка ну ка2: \(imageString)")
    }
    }
    func initCellEmpty(){
        sumHistory.text = ""
        labelHistory.text = "Покупок еще нет"
        imageHistory.image = UIImage(named: "79")
    
}
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//
//        //dismissViewControllerAnimated(true, completion: nil)
//
//        let newImageData = image.jpegData(compressionQuality: 1)
//        let myImageFromData = UIImage(data: newImageData!)
//        print("Что-нибудь: \(myImageFromData)")
//    }



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
