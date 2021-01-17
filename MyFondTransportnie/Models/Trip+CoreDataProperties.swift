//
//  Trip+CoreDataProperties.swift
//  
//
//  Created by Mac on 10.01.2021.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var cost: String?
    @NSManaged public var date: String?
    @NSManaged public var direct_img: String?
    @NSManaged public var fuel: String?
    @NSManaged public var fuel_capacity: String?
    @NSManaged public var gas: String?
    @NSManaged public var gas_capacity: String?
    @NSManaged public var gas_cost: String?
    @NSManaged public var gasoline: String?
    @NSManaged public var gasoline_capacity: String?
    @NSManaged public var gasoline_cost: String?
    @NSManaged public var id: String?
    @NSManaged public var odometer_end: String?
    @NSManaged public var odometer_end_img: String?
    @NSManaged public var odometer_end_img_url: String?
    @NSManaged public var odometer_start: String?
    @NSManaged public var odometer_start_img: String?
    @NSManaged public var odometer_start_img_url: String?
    @NSManaged public var persons: String?
    @NSManaged public var refull: String?
    @NSManaged public var routs: String?
    @NSManaged public var start_point: String?
    @NSManaged public var time: String?
    @NSManaged public var trip_name: String?
    @NSManaged public var points_obj: NSObject?
}
