//
//  ChooseCategoriesViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 01.12.2020.
//

import UIKit
import CoreData

class ChooseCategoriesViewController: UIViewController {
   
    var coppyChooseCategoriesCoreData = ChooseCategoriesCoreData()
    var copyFirstAppCoreData = FirstAppCoreData()
    
    var categoriesChoose: [String: String] = ["Автомобиль": "41", "Одежда": "10", "Развлечения": "36", "Здоровье": "32", "Красота": "29", "Продукты": "3", "Путешествия": "8", "Подарки": "14", "Дом": "27", "Домашние животные": "26", "Дети": "2", "Ремонт": "16", "Хобби": "39", "Родители": "84", "Долг": "35", "Праздники": "93", "Спорт": "97", "Другое": "75"]
    
    @IBAction func createCategory(_ sender: Any) {
      
    }

    @IBAction func nextButton(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    @IBOutlet weak var chooseCategoriesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseCategoriesTable.delegate = self
        chooseCategoriesTable.dataSource = self
        copyFirstAppCoreData.appToCoreDate()
        if copyFirstAppCoreData.firstAppCoreData.count == 0{
            addCategories()
            copyFirstAppCoreData.addToCoreDate(first: true)
        }
               appCategories()
        print("Категории равны: \(coppyChooseCategoriesCoreData.chooseCategoriesCoreData )")
    }
    func addCategories(){
        for (name, numberImage) in categoriesChoose{
            let name = name
            let numberImage = numberImage
            //coppyChooseCategoriesCoreData.appToCoreDate()
            coppyChooseCategoriesCoreData.addToCoreDate(image: "\(numberImage)", name: "\(name)", used: false)
            appCategories()
        }
       // coppyChooseCategoriesCoreData.appToCoreDate()
    }
    func appCategories(){
        coppyChooseCategoriesCoreData.appToCoreDate()
        chooseCategoriesTable.reloadData()
    }
}
extension ChooseCategoriesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //coppyChooseCategoriesCoreData.appToCoreDate()
        if  coppyChooseCategoriesCoreData.chooseCategoriesCoreData.count != 0{
            let count = coppyChooseCategoriesCoreData.chooseCategoriesCoreData.count
            //print("Количество печатает")
           return count
        } else {
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseCategoriesCell", for: indexPath) as! ChooseCategoriesTableViewCell
        
        if coppyChooseCategoriesCoreData.chooseCategoriesCoreData.count != 0{
         
           // for item in coppyChooseCategoriesCoreData.chooseCategoriesCoreData{
                let category = coppyChooseCategoriesCoreData.chooseCategoriesCoreData[indexPath.row]
                
                cell.initCell(item: category)

        }
        return cell
    }
    
    //MARK: - анимация при нажатии на ячейку
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //MARK: - нажатие на ячейку и изменение статуса
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseCategoriesCell", for: indexPath) as! ChooseCategoriesTableViewCell
        
        let category = coppyChooseCategoriesCoreData.chooseCategoriesCoreData[indexPath.row]
       // print("Категории печатает: \(category.value(forKey: "used") as! Bool)")
        
        if category == category{
            let image = category.value(forKey: "image") as! String
                    let name = category.value(forKey: "name") as! String
            category.setValue(!(category.value(forKey: "used") as! Bool), forKey: "used")
            if category.value (forKey: "used") as? Bool == false {
                cell.checkmark.image = UIImage(named: "checkin")
                let used = category.value (forKey: "used") as? Bool
                coppyChooseCategoriesCoreData.changeToCoreDate(image: "\(image)", name: "\(name)", used: !used!)
            } else {
                cell.checkmark.image = UIImage(named: "check")
                let used = category.value (forKey: "used") as? Bool
                coppyChooseCategoriesCoreData.changeToCoreDate(image: "\(image)", name: "\(name)", used: !used!)
               
            }
            
            
//        if (category.value(forKey: "used") as! Bool) == false{
//          //  appCategories()
//            let image = category.value(forKey: "image") as! String
//            let name = category.value(forKey: "name") as! String
//            coppyChooseCategoriesCoreData.changeToCoreDate(image: "\(image)", name: "\(name)", used: true)
//            cell.checkmark.image = UIImage(named: "check")
//           // appCategories()
//
//        } else {
//            let image = category.value(forKey: "image") as! String
//            let name = category.value(forKey: "name") as! String
//            coppyChooseCategoriesCoreData.changeToCoreDate(image: "\(image)", name: "\(name)", used: false)
//            cell.checkmark.image = UIImage(named: "checkin")
//            //appCategories()
//        }
        }
        appCategories()
    }
}
