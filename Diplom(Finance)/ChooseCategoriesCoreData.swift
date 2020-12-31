//
//  ChooseCategoriesCoreData.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 29.12.2020.
//

import UIKit
import Foundation
import CoreData

class ChooseCategoriesCoreData {
    static let shared = ChooseCategoriesCoreData()
    var chooseCategoriesCoreData: [NSManagedObject] = []
    
    //MARK: - работа в базе
    func appToCoreDate () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChooseCategories")
        do {
            chooseCategoriesCoreData = try! context.fetch(fetchRequest) as? [NSManagedObject] ?? [NSManagedObject]()
        }
    }
    
    //MARK: - добавление новых ячеек в базе
    
    func addToCoreDate (image: String, name: String, used: Bool) {
        
        appToCoreDate ()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "ChooseCategories", in: context) else { return }
        
        let categoryToAdd = NSManagedObject.init(entity: entity, insertInto: context)
        
        categoryToAdd.setValue(image, forKey: "image")
        categoryToAdd.setValue(name, forKey: "name")
        categoryToAdd.setValue(used, forKey: "used")

        
        do {
            try! context.save()
            chooseCategoriesCoreData.append(categoryToAdd)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    //MARK: - сохранение изменений в базе
    
    func changeToCoreDate (image: String, name: String, used: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "ChooseCategories", in: context) else { return }
        do {
            try! context.save()
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }   
}
