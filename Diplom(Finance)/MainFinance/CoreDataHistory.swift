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
    
    func addToCoreDate (sum: String, label: String, image: String) {
        
        appToCoreDate ()
        
//        if coreDataHistory.count != 0{
//            for item in coreDataHistory {
//                if let sumTemp = item.value(forKey: "sum") as? String, sumTemp == sum,
//                   let labelTemp = item.value(forKey: "label") as? String, labelTemp == label,
//                   let imageTemp = item.value(forKey: "image") as? String,
//                   imageTemp == image {
//                    
//                    changeToCoreDate(sum: sum, label: label, image: image)
//                    appToCoreDate ()
//                    return
//                }
//            }
//        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "HistoryTable", in: context) else { return }
        
        let productToAdd = NSManagedObject.init(entity: entity, insertInto: context)
        
        productToAdd.setValue(sum, forKey: "sum")
        productToAdd.setValue(label, forKey: "label")
        productToAdd.setValue(image, forKey: "image")

        
        do {
            try! context.save()
            coreDataHistory.append(productToAdd)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    //MARK: - сохранение изменений в базе
    
    func changeToCoreDate (sum: String, label: String, image: String) {
        
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
