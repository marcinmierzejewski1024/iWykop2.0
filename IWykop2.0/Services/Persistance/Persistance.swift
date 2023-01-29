//
//  Persistance.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 29/01/2023.
//

import Foundation

protocol Persistance {
    func setObject(_ object: Codable, for key: String)
    func object<T>(for key: String) -> T?
}


final class UserDefaultsPersistance: Persistance {
    func setObject(_ object: Codable, for key: String) {
        UserDefaults.standard.setValue(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func object<T>(for key: String) -> T? {
        UserDefaults.standard.object(forKey:key) as? T
    }
}
