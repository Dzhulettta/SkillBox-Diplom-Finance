//
//  CreateCategoryViewController.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 03.12.2020.
//

import UIKit

class CreateCategoryViewController: UIViewController {
    var copyChooseCategoriesCoreData = ChooseCategoriesCoreData()
    
    @IBOutlet weak var nameFieldOutlet: UITextField!
    @IBAction func nameFieldAction(_ sender: Any) {
    }
    @IBOutlet weak var collectionImages: UICollectionView!
    
    @IBOutlet weak var saveNewCategoryOutlet: UIButton!
    @IBAction func saveNewCategoryAction(_ sender: Any) {
        self.collectionImages.reloadData()

        copyChooseCategoriesCoreData.addToCoreDate(image: "\( NewCategoryForUserDefaults.shared.imageKey)", name: "\(nameFieldOutlet.text!)", used: true)

        dismiss(animated: true, completion: .none)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionImages.delegate = self
        collectionImages.dataSource = self
        collectionImages.allowsMultipleSelection = true

        saveNewCategoryOutlet.isEnabled = false
        saveNewCategoryOutlet.backgroundColor = .systemGray
        saveNewCategoryOutlet.layer.cornerRadius = 7.5
    }
    func checkOut(){
        self.collectionImages.reloadData()

        if (nameFieldOutlet.text != "") && NewCategoryForUserDefaults.shared.imageKey != nil{
            saveNewCategoryOutlet.isEnabled = true
            saveNewCategoryOutlet.backgroundColor = .systemBlue
        }
    }
}
extension CreateCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 120
    }
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createCell", for: indexPath) as! CreateCategoryCollectionViewCell
        
        var imageForCategory: [Int] = []
        for item in [2 ... 121]{
            imageForCategory.append(contentsOf: item)
        }
        cell.imageNewCategory.image =  UIImage(named: "\(imageForCategory[indexPath.row])")
        return cell
    }
    //MARK: - анимация при нажатии на ячейку
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    //MARK: - Нажатие на ячейку
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createCell", for: indexPath) as! CreateCategoryCollectionViewCell
        cell.imageNewCategory.backgroundColor = .red
        cell.chooseImage.isHidden = false
        
        cell.chooseImage.backgroundColor = .systemBlue
      
        NewCategoryForUserDefaults.shared.imageKey = "\(cell.imageNewCategory.image)"
        //print("Такое вот описание \(cell.imageNewCategory.image)")

        checkOut()
            self.collectionImages.reloadData()
    }

}
