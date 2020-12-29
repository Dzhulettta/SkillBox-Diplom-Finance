//
//  SetLimit.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 27.12.2020.
//

import UIKit
import Foundation
import CoreData

class CoreDataSetLimit {
    static let shared = CoreDataSetLimit()
    var coreDataSetLimit: [NSManagedObject] = []
    
    //MARK: - работа в базе
    func appToCoreDate () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SetLimit")
        do {
            coreDataSetLimit = try! context.fetch(fetchRequest) as? [NSManagedObject] ?? [NSManagedObject]()
        }
    }
    
    //MARK: - добавление новых ячеек в базе
    
    func addToCoreDate (limit: String) {
        
        appToCoreDate ()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SetLimit", in: context) else { return }
        
        let limitToAdd = NSManagedObject.init(entity: entity, insertInto: context)
        
        limitToAdd.setValue(limit, forKey: "limit")
     
        do {
            try! context.save()
            coreDataSetLimit.append(limitToAdd)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    //MARK: - сохранение изменений в базе
    
    func changeToCoreDate (limit: String) {
        
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
