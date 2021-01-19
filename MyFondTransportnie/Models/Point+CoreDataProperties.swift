//
//  Point+CoreDataProperties.swift
//  
//
//  Created by Mac on 19.01.2021.
//
//

import Foundation
import CoreData


extension Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point")
    }

    @NSManaged public var distance: Double
    @NSManaged public var no: String?
    @NSManaged public var sity: String?
    @NSManaged public var street: String?
    @NSManaged public var target_de: String?
    @NSManaged public var target_ru: String?
    @NSManaged public var type: String?
    @NSManaged public var trip: Trip?

}
