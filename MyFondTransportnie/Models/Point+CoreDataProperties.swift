//
//  Point+CoreDataProperties.swift
//  
//
//  Created by Mac on 20.01.2021.
//
//

import Foundation
import CoreData


extension Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point")
    }

    @NSManaged public var sort_number: Int16 // This index need be cos "ordered" option in relationships configurator isn`t working
    @NSManaged public var distance: Double
    @NSManaged public var no: String?
    @NSManaged public var sity: String?
    @NSManaged public var street: String?
    @NSManaged public var target_de: String?
    @NSManaged public var target_ru: String?
    @NSManaged public var type: String?
    @NSManaged public var trip: Trip?

}
