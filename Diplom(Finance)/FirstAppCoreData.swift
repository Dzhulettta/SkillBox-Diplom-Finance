//
//  FirstAppCoreData.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 30.12.2020.
//

import UIKit
import Foundation
import CoreData

class FirstAppCoreData {
    static let shared = FirstAppCoreData()
    var firstAppCoreData: [NSManagedObject] = []
    
    //MARK: - работа в базе
    func appToCoreDate () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FirstApp")
        do {
            firstAppCoreData = try! context.fetch(fetchRequest) as? [NSManagedObject] ?? [NSManagedObject]()
        }
    }
    
    //MARK: - добавление новых ячеек в базе
    
    func addToCoreDate (first: Bool) {
        
        appToCoreDate ()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FirstApp", in: context) else { return }
        
        let firstAppInt = NSManagedObject.init(entity: entity, insertInto: context)
        
        firstAppInt.setValue(first, forKey: "first")
  
        
        do {
            try! context.save()
            firstAppCoreData.append(firstAppInt)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
}

