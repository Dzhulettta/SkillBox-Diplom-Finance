//
//  MainFinanceViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 30.11.2020.
//

import UIKit
import CoreData

class MainFinanceViewController: UIViewController{
    
    
    var copyCoreDataHistory = CoreDataHistory()
    var copyCoreDataSetLimit = CoreDataSetLimit()
    var nameCategory = ""
    var summCategory = ""
    var checkDisplay = false
    @IBOutlet weak var displayLabel: UILabel!
    
    var categoriesChoose: [String: String] = ["Автомобиль": "41", "Одежда": "10", "Развлечения": "36", "Здоровье": "32", "Красота": "29", "Продукты": "3", "Путешествия": "8", "Подарки": "14", "Дом": "27", "Домашние животные": "26", "Дети": "2", "Ремонт": "16", "Хобби": "39", "Родители": "84", "Долг": "35", "Праздники": "93", "Спорт": "97", "Другое": "75"]
    //[:]
    
    
    @IBAction func numberPrassed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if displayLabel.text!.count < 15{
            if checkDisplay{
                displayLabel.text = displayLabel.text! + number
            } else {
                displayLabel.text = number
                checkDisplay = true
            }
        }
    }
    @IBAction func resetButton(_ sender: Any) {
        displayLabel.text = "0"
        checkDisplay = false
    }
    
    var categories: [String : String] = [:]
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var spendingLabel: UILabel!
    @IBOutlet weak var allSpendingLabel: UILabel!
    
    
    @IBOutlet weak var threeButton: UIButton!
    
    @IBAction func setLimit(_ sender: Any) {
        alertLimit()
        
    }
    
    @IBOutlet weak var tableHistory: UITableView!
    @IBOutlet weak var collectionCategories: UICollectionView!
    
    func allSpending(){
        if copyCoreDataHistory.coreDataHistory.count != 0{
            var allPrice = 0
            for item in (0 ...  (copyCoreDataHistory.coreDataHistory.count - 1))
            {
                let priceA = (copyCoreDataHistory.coreDataHistory[item].value(forKey: "sum") as! NSString).integerValue
                
                
                allPrice += priceA
            }
            spendingLabel.text = "\(allPrice)₽"
            
        } else {
            spendingLabel.text = "0₽"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let widthButton = self.view.bounds.width / 6
        let heightButton = widthButton
        threeButton.bounds.size.width = CGFloat(widthButton)
        threeButton.bounds.size.height = threeButton.bounds.size.width
        collectionCategories.delegate = self
        collectionCategories.dataSource = self
        tableHistory.delegate = self
        tableHistory.dataSource = self
        tableHistory.tableFooterView = UIView() //у таблицы убирает незаполненные ячейки в таблице
        reload()
        
        if copyCoreDataSetLimit.coreDataSetLimit.count != 0 {
            limitLabel.text = copyCoreDataSetLimit.coreDataSetLimit[0].value(forKey: "limit") as? String
        } else {
            limitLabel.text = "0₽"
        }
        //        let limitL = Int(limitLabel.text!)
        //        print("лимит: \(limitL)")
        //        let spendingL = Int(spendingLabel.text!)
        //        print("затраты: \(spendingL)")
        //        availableLabel.text = "\(limitL! - spendingL!)"
    }
    func reload(){
        copyCoreDataHistory.appToCoreDate()
        CoreDataHistory.shared.appToCoreDate()
        tableHistory.reloadData()
        allSpending()
    }
}
extension MainFinanceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categoriesChoose.count != 0{
            return categoriesChoose.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCollectionViewCell
        if categoriesChoose.count != 0{
            var keysArray: [Any] = []
            var valiesArray: [Any] = []
            for (key, value) in categoriesChoose{
                let myKey = key
                let myValue = value
                keysArray.append(myKey)
                valiesArray.append(myValue)
            }
            cell.labelCategory.text = "\(keysArray[indexPath.row])"
            cell.imageCategory.image = UIImage(named: "\(valiesArray[indexPath.row])")
        } else {
            cell.labelCategory.text = "Выберите категории"
            cell.imageCategory.image = UIImage(named: "120")
        }
        return cell
    }
    
    //MARK: - Нажатие на ячейку
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        reload()
        
        if categoriesChoose.count == 0{
            
            if let chooseCategoriesViewController = storyboard?.instantiateViewController(identifier: "ChooseCategoriesViewController"){
                performSegue(withIdentifier: "showChooseCategories", sender: Any?.self)
                displayLabel.text = "0"
                checkDisplay = false
            }
        }
        if displayLabel.text != "0"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCollectionViewCell
            
            let sum = displayLabel.text!
            let label = cell.labelCategory.text!
            
            let image = cell.imageCategory.image!
            print("Сумма: \(sum)")
            copyCoreDataHistory.addToCoreDate(sum: "\(sum)", label: "\(label)", image: "\(image)")
            reload()
            print("Имадж: \(image)")
            
            
            
            
            
            //            super.viewDidLoad()
            
            //            print("картинк: \(label)")
            displayLabel.text = "0"
            checkDisplay = false
        }
    }
    func alertLimit() {
        let alertController = UIAlertController(title: "Установите лимит", message: .none, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Ведите сумму"
        }
        
        let alertAction1 = UIAlertAction(title: "Oк", style: .cancel) { (alert) in
            
            
            guard let newItem = alertController.textFields?.last?.text else { return }
            if newItem != ""{
                self.limitLabel.text = "\(newItem)₽"
                self.copyCoreDataSetLimit.appToCoreDate ()
                if self.copyCoreDataSetLimit.coreDataSetLimit.count == 0{
                    self.copyCoreDataSetLimit.addToCoreDate(limit: "\(newItem)₽")
                } else {
                    self.copyCoreDataSetLimit.changeToCoreDate(limit: "\(newItem)₽")
                }
            }
            
            
        }
        let alertAction2 = UIAlertAction(title: "Отмена", style: .default) { (alert) in
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion:  nil)
    }
}
extension MainFinanceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if copyCoreDataHistory.coreDataHistory.count == 0{
            return 1
        } else {
            return copyCoreDataHistory.coreDataHistory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath) as! HistoryTableViewCell
        if copyCoreDataHistory.coreDataHistory.count == 0{
            
            cell.initCellEmpty()
            return cell
        } else {
            copyCoreDataHistory.appToCoreDate()
            let productCD = copyCoreDataHistory.coreDataHistory[indexPath.row]
            
            cell.initCell(item: productCD)
            
            return cell
        }
    }
}
