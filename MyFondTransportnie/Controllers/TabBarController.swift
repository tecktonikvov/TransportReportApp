//
//  TabBarController.swift
//  MyFondTransportnie
//
//  Created by Mac on 03.01.2021.
//

import UIKit

class TabBarController: UITabBarController {

    static var shared = TabBarController()
    var currentTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentTrip != nil {
            (self.viewControllers![0] as! DescVC).currentTrip = currentTrip!
        }
    }

}
