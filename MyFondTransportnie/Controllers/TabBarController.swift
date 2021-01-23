//
//  TabBarController.swift
//  MyFondTransportnie
//
//  Created by Mac on 03.01.2021.
//

import UIKit
import CoreData

class TabBarController: UITabBarController {
//We update propperty "currentTrip" and "newPointList" when we switch between tabBar controllers
    var currentTrip: Trip?
    var newTrip: Trip?
    var newPointList: [Point]? {
        didSet {
          //We must get mutableCopy of Trip.points and edit it because Trip.point propperty is NSSet
            let point = currentTrip!.point!
            let mutableCopy = point.mutableCopy() as! NSMutableSet
            mutableCopy.removeAllObjects()
            mutableCopy.addObjects(from: newPointList!)
            currentTrip?.point = mutableCopy
            print("==============================")
            //print(currentTrip?.point)
            print("==============================")

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentTrip == nil {
            newTrip = DataManager.createNewEntity(entityName: "Trip") as? Trip
        }
    }
    
    deinit {
        print("TabBar Deinit")
    }
}


