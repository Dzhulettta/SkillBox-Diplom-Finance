//
//  CoreDataHistory.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 26.12.2020.
//

import UIKit
import Foundation
import CoreData

class CoreDataHistory {
    static let shared = CoreDataHistory()
    var coreDataHistory: [NSManagedObject] = []
    
    //MARK: - работа в базе
    func appToCoreDate () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryTable")
        do {
            coreDataHistory = try! context.fetch(fetchRequest) as? [NSManagedObject] ?? [NSManagedObject]()
        }
    }
    
    //MARK: - добавление новых ячеек в базе
    
    func addToCoreDate (sum: String, label: String, image: String, data: String, used: Bool) {
        
        appToCoreDate ()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "HistoryTable", in: context) else { return }
        
        let productToAdd = NSManagedObject.init(entity: entity, insertInto: context)
        
        productToAdd.setValue(sum, forKey: "sum")
        productToAdd.setValue(label, forKey: "label")
        productToAdd.setValue(image, forKey: "image")
        productToAdd.setValue(data, forKey: "data")
        productToAdd.setValue(used, forKey: "used")
        
        do {
            try! context.save()
            coreDataHistory.append(productToAdd)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    //MARK: - сохранение изменений в базе
    
    func changeToCoreDate (sum: String, label: String, image: String, data: String, used: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "HistoryTable", in: context) else { return }
        do {
            try! context.save()
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
}
