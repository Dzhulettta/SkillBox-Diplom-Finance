//
//  MainFinanceViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 30.11.2020.
//

import UIKit

class MainFinanceViewController: UIViewController{
//    var categoriesChoose: [String] = ["Автомобиль", "Одежда", "Развлечения", "Здоровье", "Красота", "Другое", "Путешествия", "Подарки", "Дом", "Личные расходы", "Домашние животные", "Дети", "Бытовая техника", "Ремонт", "Хобби", "Родители", "Долг", "Праздники"]
    
    var categoriesChoose: [String: String] = ["Автомобиль": "41", "Одежда": "10", "Развлечения": "36", "Здоровье": "32", "Красота": "29", "Продукты": "3", "Путешествия": "8", "Подарки": "14", "Дом": "27", "Домашние животные": "26", "Дети": "2", "Ремонт": "16", "Хобби": "39", "Родители": "84", "Долг": "35", "Праздники": "93", "Спорт": "97", "Другое": "75"]
    
    var categories: [String : String] = [:]
    @IBOutlet weak var limitLabel: UILabel!
    
    @IBOutlet weak var threeButton: UIButton!
    
    @IBAction func button1(_ sender: Any) {
    }
    @IBAction func button2(_ sender: Any) {
    }
    @IBAction func button3(_ sender: Any) {
    }
    @IBAction func button4(_ sender: Any) {
    }
    @IBAction func button5(_ sender: Any) {
    }
    @IBAction func button6(_ sender: Any) {
    }
    @IBAction func button7(_ sender: Any) {
    }
    @IBAction func button8(_ sender: Any) {
    }
    @IBAction func button9(_ sender: Any) {
    }
    @IBAction func button0(_ sender: Any) {
    }
    @IBAction func buttonC(_ sender: Any) {
    }
    @IBAction func setLimit(_ sender: Any) {
    }
    @IBOutlet weak var collectionCategories: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let widthButton = self.view.bounds.width / 6
        let heightButton = widthButton
        threeButton.bounds.size.width = CGFloat(widthButton)
        threeButton.bounds.size.height = threeButton.bounds.size.width
        collectionCategories.delegate = self
        collectionCategories.dataSource = self
        
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
            cell.labelCategory.text = "Выбирете категории"
            cell.imageCategory.image = UIImage(named: "120")
        }
        return cell
    }

    //MARK: - Нажатие на ячейку
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
}
    

}
