//
//  Trip+CoreDataProperties.swift
//  
//
//  Created by Mac on 19.01.2021.
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
    @NSManaged public var point_obj: NSObject?
    @NSManaged public var refull: String?
    @NSManaged public var routs: String?
    @NSManaged public var start_point: String?
    @NSManaged public var time: String?
    @NSManaged public var trip_name: String?
    @NSManaged public var point: NSSet?

}

// MARK: Generated accessors for point
extension Trip {

    @objc(insertObject:inPointAtIndex:)
    @NSManaged public func insertIntoPoint(_ value: Point, at idx: Int)

    @objc(removeObjectFromPointAtIndex:)
    @NSManaged public func removeFromPoint(at idx: Int)

    @objc(insertPoint:atIndexes:)
    @NSManaged public func insertIntoPoint(_ values: [Point], at indexes: NSIndexSet)

    @objc(removePointAtIndexes:)
    @NSManaged public func removeFromPoint(at indexes: NSIndexSet)

    @objc(replaceObjectInPointAtIndex:withObject:)
    @NSManaged public func replacePoint(at idx: Int, with value: Point)

    @objc(replacePointAtIndexes:withPoint:)
    @NSManaged public func replacePoint(at indexes: NSIndexSet, with values: [Point])

    @objc(addPointObject:)
    @NSManaged public func addToPoint(_ value: Point)

    @objc(removePointObject:)
    @NSManaged public func removeFromPoint(_ value: Point)

    @objc(addPoint:)
    @NSManaged public func addToPoint(_ values: NSOrderedSet)

    @objc(removePoint:)
    @NSManaged public func removeFromPoint(_ values: NSOrderedSet)

}
