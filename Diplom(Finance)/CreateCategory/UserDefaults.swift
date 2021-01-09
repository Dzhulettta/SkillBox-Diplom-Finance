//
//  UserDefaults.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 03.12.2020.
//

import Foundation
class NewCategoryForUserDefaults {
static let shared = NewCategoryForUserDefaults()
    
    private let kImageKey = "NewCategoryForUserDefaults.imageKey"
      var imageKey: String? {
          set { UserDefaults.standard.set(newValue, forKey: kImageKey)}
          get { return UserDefaults.standard.string(forKey: kImageKey)}
      }

}
