//
//  TabBarController.swift
//  MyFondTransportnie
//
//  Created by Mac on 03.01.2021.
//

import UIKit
import CoreData

class TabBarController: UITabBarController {
    
    var currentTrip: Trip?
    var newTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentTrip == nil {
            newTrip = Trip(context: CoreDataManager.context)
            //newTrip = DataManager.getNewEntity(entityName: "Trip")
        }
    }
    
    deinit {
        print("TabBar Deinit")
    }
}


