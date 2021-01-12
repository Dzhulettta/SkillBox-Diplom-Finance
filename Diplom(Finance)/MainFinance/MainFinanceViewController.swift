//
//  MainFinanceViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 30.11.2020.
//

import UIKit
import CoreData

class MainFinanceViewController: UIViewController{
    var copyChooseCategoriesCoreData = ChooseCategoriesCoreData()
    var copyCoreDataHistory = CoreDataHistory()
    
    var nameCategory = ""
    var summCategory = ""
    var checkDisplay = false
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var historyAllOutlet: UIButton!
    @IBAction func historyAllButton(_ sender: Any) {
        //        tableHistory.autoresizesSubviews = true
        //        tableHistory.bounds.size.height = self.view.bounds.size.height
    }
    
    
    var time = NSDate()
    var formatter = DateFormatter()
    func dataNow(sum: String, label: String, image: String, data: String){
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)            // указатель временной зоны относительно гринвича
        var formatteddate = formatter.string(from: time as Date)
        copyCoreDataHistory.addToCoreDate(sum: "\(sum)", label: "\(label)", image: "\(image)", data: "\(formatteddate)", used: true)
    }
    
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
    
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var spendingLabel: UILabel!
    @IBOutlet weak var allSpendingLabel: UILabel!
    
    
    @IBOutlet weak var threeButton: UIButton!
    
    @IBAction func setLimit(_ sender: Any) {
        alertLimit()
        allSpending()
    }
    @IBAction func setPeriod(_ sender: Any) {
    }
    
    @IBOutlet weak var tableHistory: UITableView!
    @IBOutlet weak var collectionCategories: UICollectionView!
    
    @IBAction func addCategories(_ sender: Any) {
        if let chooseCategoriesViewController = storyboard?.instantiateViewController(identifier: "ChooseCategoriesViewController"){
            performSegue(withIdentifier: "showChooseCategories", sender: Any?.self)
            displayLabel.text = "0"
            checkDisplay = false
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    func allSpending(){
        if copyCoreDataHistory.coreDataHistory.count != 0{
            var allPrice = 0
            for item in (0 ...  (copyCoreDataHistory.coreDataHistory.count - 1))
            {
                let priceA = (copyCoreDataHistory.coreDataHistory[item].value(forKey: "sum") as! NSString).integerValue
                allPrice += priceA
            }
            spendingLabel.text = "\(allPrice)₽"
            var limit = SetLimitUserDefaults.shared.limitKey ?? 0
            if limit < allPrice{
                availableLabel.text = "Вы вышли из бюджета на: \((allPrice - limit))₽"
            } else {
                availableLabel.text = "\(limit - allPrice)₽"
            }
        }
    }
    
    func reload(){
        copyChooseCategoriesCoreData.appToCoreDate()
        copyCoreDataHistory.appToCoreDate()
        CoreDataHistory.shared.appToCoreDate()
        collectionCategories.reloadData()
        tableHistory.reloadData()
        allSpending()
        
        let limit = SetLimitUserDefaults.shared.limitKey ?? 0
        limitLabel.text = "\(limit)₽"
    }
    func alertLimit() {
        let alertController = UIAlertController(title: "Установите лимит", message: .none, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Ведите сумму"
        }
        let alertAction1 = UIAlertAction(title: "Oк", style: .cancel) { (alert) in
            
            guard var newItem = alertController.textFields?.last?.text else { return }
            if newItem != ""{
                SetLimitUserDefaults.shared.limitKey = Int(newItem)
                self.limitLabel.text = "\(SetLimitUserDefaults.shared.limitKey!)₽"
                self.allSpending()
            }
        }
        let alertAction2 = UIAlertAction(title: "Отмена", style: .default) { (alert) in
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion:  nil)
    }
}

extension MainFinanceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        copyChooseCategoriesCoreData.appToCoreDate()
        let category = copyChooseCategoriesCoreData.chooseCategoriesCoreData
        var count = 0
        if category != nil{
            for item in category{
                if (item.value(forKey: "used") as! Bool) == true{
                    count += 1
                }
            }
            if count != 0{
                return count
            } else {
                return 0
            }
            return 0
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCollectionViewCell
        copyChooseCategoriesCoreData.appToCoreDate()
        if copyChooseCategoriesCoreData.chooseCategoriesCoreData.count != 0{
            var usedCategory: [NSManagedObject] = []
            
            let category = copyChooseCategoriesCoreData.chooseCategoriesCoreData
            
            if category != nil{
                for item in category{
                    if (item.value(forKey: "used") as! Bool) == true{
                        usedCategory.append(item)
                    }
                }
                for item in category{
                    if (item.value(forKey: "used") as! Bool) == true{
                        cell.initCell(item: usedCategory[indexPath.row])
                        
                    }
                }
            }
        }
        return cell
    }
    
    //MARK: - Нажатие на ячейку
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        copyChooseCategoriesCoreData.appToCoreDate()
        let category = copyChooseCategoriesCoreData.chooseCategoriesCoreData
        var usedCategory: [NSManagedObject] = []
        
        var count = 0
        for item in category{
            if (item.value(forKey: "used") as! Bool) == true{
                count += 1
            }
        }
        if count == 0{
            if let chooseCategoriesViewController = storyboard?.instantiateViewController(identifier: "ChooseCategoriesViewController"){
                performSegue(withIdentifier: "showChooseCategories", sender: Any?.self)
                displayLabel.text = "0"
                checkDisplay = false
            }
        } else {
            if displayLabel.text != "0"{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCollectionViewCell
                if category == category{
                    for item in category{
                        if (item.value(forKey: "used") as! Bool) == true{
                            usedCategory.append(item)
                        }
                    }
                    let sum = displayLabel.text!
                    let label = usedCategory[indexPath.row].value(forKey: "name")
                    let image = usedCategory[indexPath.row].value(forKey: "image")
                    dataNow(sum: "\(sum)", label: "\(label!)", image: "\(image!)", data: "")
                    reload()
                }
            }
            displayLabel.text = "0"
            checkDisplay = false
        }
    }
}

extension MainFinanceViewController: UITableViewDelegate, UITableViewDataSource{
    // возвращает количество секций
    func countSection()-> Int{
        copyCoreDataHistory.appToCoreDate()
        CoreDataHistory.shared.appToCoreDate()
        let historyData = copyCoreDataHistory.coreDataHistory
        var count = 1
        if historyData.count != 0{
            var itemOne = historyData[0].value(forKey: "data") as! String
            for item in historyData{
                if itemOne != (item.value(forKey: "data") as! String){
                    count += 1
                    itemOne = item.value(forKey: "data") as! String
                }
            }
        }
        return count
    }
    
    // возвращает количество ячеек в секции
    func countRowInSection(item: Int)-> Int{
        //let count = countSection()
        copyCoreDataHistory.appToCoreDate()
        var countRow = 1
        let historyData = copyCoreDataHistory.coreDataHistory
        if historyData.count != 0{
            countRow = 0
            var itemOne = historyData[item].value(forKey: "data") as! String
            for item in 0 ... (historyData.count - 1){
                //                var i = item as! Int
                if itemOne == historyData[item].value(forKey: "data") as! String{
                    
                    countRow += 1
                }
            }
        }
        return countRow
    }
    
    // возвращает количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return countSection()
    }
    
    //  возвращает подпись секций
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count: Int = countSection()
        //print ("Count: \(count)")
        copyCoreDataHistory.appToCoreDate()
        let historyData = CoreDataHistory.shared.coreDataHistory
        if historyData.count != 0{
            //var itemOne = historyData[item].value(forKey: "data") as! String
            var arrayData1: [String] = []
            for item in historyData{
                let title = "\(item.value(forKey: "data") as! String)"
                arrayData1.append(title as! String)
            }
            let arrayData = Dictionary(grouping: arrayData1, by: {$0}).filter { $1.count > 1 }.keys
           // print("DataNow qqqq \(arrayData)")
            
            
            //////////////// Почему перемешивается при обновлении??????????????
            for i in arrayData {
                
                var title = "\(i)"
                return title
            }
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if copyCoreDataHistory.coreDataHistory.count != 0{
            let countSectionInt = countSection()
            var countRowsInSectionInt = 1
            for item in 0 ..< countSectionInt{
                // var i: Int = item as! Int
                var count = countRowInSection(item: item)
                countRowsInSectionInt = count as! Int
                return countRowsInSectionInt
            }
            return countRowsInSectionInt
        } else {
            return 1
        }
        // return countRowsInSectionInt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath) as! HistoryTableViewCell
        if copyCoreDataHistory.coreDataHistory.count == 0{
                        cell.initCellEmpty()
            return cell
        } else {
            copyCoreDataHistory.appToCoreDate()
            CoreDataHistory.shared.appToCoreDate()
                        var historyCategory: [NSManagedObject] = []
            let history = copyCoreDataHistory.coreDataHistory
            if history != nil{
                for item in history{
                        cell.initCell(item: history[indexPath.row])
                }
                    }
    
            return cell
        }
    }
}
