//
//  ChooseCategoriesViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 01.12.2020.
//

import UIKit
import CoreData

class ChooseCategoriesViewController: UIViewController {
    var categoriesCoreData: [NSManagedObject] = []    //создание экземпляра базы данных
    @IBAction func createCategory(_ sender: Any) {
//        saveNewCategory()
        
    }
    var categoriesChoose: [String: String] = ["Автомобиль": "41", "Одежда": "10", "Развлечения": "36", "Здоровье": "32", "Красота": "29", "Продукты": "3", "Путешествия": "8", "Подарки": "14", "Дом": "27", "Домашние животные": "26", "Дети": "2", "Ремонт": "16", "Хобби": "39", "Родители": "84", "Долг": "35", "Праздники": "93", "Спорт": "97", "Другое": "75"]

    @IBOutlet weak var chooseCategoriesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        chooseCategoriesTable.delegate = self
        chooseCategoriesTable.dataSource = self
        
    }
//    func saveNewCategory() {
//
//        let alertController = UIAlertController(title: "Создать новую категорию", message: .none, preferredStyle: .alert)
//
//        alertController.addTextField { textField in
//            textField.placeholder = "Ведите название"
//        }
//        let alertAction1 = UIAlertAction(title: "Отмена", style: .default) { (alert) in
//        }
//        let alertAction2 = UIAlertAction(title: "Выбрать иконку", style: .cancel) { (alert) in
//
//            guard let newItem = alertController.textFields?.last?.text else { return }
//            let done = false
//            //self.addToCoreDate(item: newItem, done: done)
//            self.chooseCategoriesTable.reloadData()
//        }
//        alertController.addAction(alertAction1)
//        alertController.addAction(alertAction2)
//        present(alertController, animated: true, completion:  nil)
//    }

 

}
extension ChooseCategoriesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesChoose.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseCategoriesCell", for: indexPath) as! ChooseCategoriesTableViewCell
        if categoriesChoose.count != 0{
            var keysArray: [Any] = []
        for (key, _) in categoriesChoose{
            let myKey = key
            keysArray.append(myKey)
        cell.accessoryType = .none
        }
            cell.categoryLabel.text = "\(keysArray[indexPath.row])"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseCategoriesCell", for: indexPath) as! ChooseCategoriesTableViewCell
        
        if cell.accessoryType == .none{
            cell.accessoryType = .checkmark
            chooseCategoriesTable.reloadData()
        } else {
            cell.accessoryType = .none
            chooseCategoriesTable.reloadData()
        }
    }
}
