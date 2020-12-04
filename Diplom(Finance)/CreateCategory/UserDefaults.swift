//
//  UserDefaults.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 03.12.2020.
//

import Foundation
class NewCategoryForUserDefaults {
static let shared = NewCategoryForUserDefaults()
    
  private let kNameKey = "NewCategoryForUserDefaults.nameKey"
    var nameKey: String? {
        set { UserDefaults.standard.set(newValue, forKey: kNameKey)}
        get { return UserDefaults.standard.string(forKey: kNameKey)}
    }
    private let kImageKey = "NewCategoryForUserDefaults.imageKey"
      var imageKey: String? {
          set { UserDefaults.standard.set(newValue, forKey: kImageKey)}
          get { return UserDefaults.standard.string(forKey: kImageKey)}
      }
    private let kUsedKey = "NewCategoryForUserDefaults.usedKey"
      var usedKey: Bool? {
          set { UserDefaults.standard.set(newValue, forKey: kUsedKey)}
          get { return UserDefaults.standard.bool(forKey: kUsedKey)}
      }
}
