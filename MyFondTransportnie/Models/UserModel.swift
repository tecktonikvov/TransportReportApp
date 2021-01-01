//
//  UserModel.swift
//  MyFondTransportnie
//
//  Created by Mac on 20.12.2020.
//

import Foundation

class UserModel: NSObject, NSCoding {

    
    var userName: String
    var lastEnterDate: Date = Date()
    
    init(userName: String) {
        self.userName = userName
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userName, forKey: "userName")
        coder.encode(lastEnterDate, forKey: "lastEnterDate")
    }
    
    required init?(coder: NSCoder) {
        userName = coder.decodeObject(forKey: "userName") as? String ?? ""
        lastEnterDate = coder.decodeObject(forKey: "lastEnterDate") as? Date ?? Date()

    }
}
