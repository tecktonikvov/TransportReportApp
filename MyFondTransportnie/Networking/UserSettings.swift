//
//  UserModel.swift
//  MyFondTransportnie
//
//  Created by Mac on 20.12.2020.
//

import Foundation

final class UserSettings{
    
    static var userModel: UserModel! {
        get{
            guard let savedData = UserDefaults.standard.object(forKey: "userModel") as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel else {return nil}
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: "userModel")
                }
            } else {
                defaults.removeObject(forKey: "userModel")
            }
        }
    }
    
    static var userName: String! {
        get {
            return UserDefaults.standard.string(forKey: "userName")
        } set {
            let defaults = UserDefaults.standard
            if let name = newValue{
                defaults.set(name, forKey: "userName")
            } else {
                defaults.removeObject(forKey: "userName") // если получаем nil то и в памяти удаляем этот обьект
            }
        }
    }
}
