//
//  SetLimitUserDefaults.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 27.12.2020.
//

import Foundation
class SetLimitUserDefaults {
static let shared = SetLimitUserDefaults()
    
    private let kLimitKey = "SetLimitUserDefaults.limitKey"
      var limitKey: Int? {
          set { UserDefaults.standard.set(newValue, forKey: kLimitKey)}
        get { return UserDefaults.standard.integer(forKey: kLimitKey)}
      }

}
    
