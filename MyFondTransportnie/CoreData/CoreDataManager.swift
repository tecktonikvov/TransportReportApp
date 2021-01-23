//
//  CoreDataManager.swift
//  MyFondTransportnie
//
//  Created by Mac on 21.12.2020.
//

import Foundation
import CoreData

class CoreDataManager {
    static let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    private func createUserEntityFrom(dictionary: [String:AnyObject]) -> NSManagedObject? {
        if let userEntity = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataManager.context) as? User {
            userEntity.abbrev = dictionary["abbrev"] as? String
            userEntity.active = dictionary["active"] as? String
            userEntity.name_en = dictionary["name_en"] as? String
            userEntity.surname_en = dictionary["surname_en"] as? String
            userEntity.name_ru = dictionary["name_ru"] as? String
            userEntity.surname_ru = dictionary["surname_ru"] as? String
            userEntity.type = dictionary["type"] as? String
            return userEntity
        }
        return nil
    }
    
    private func createPointEntityFrom(dictionary: NSArray, tripEntity: Trip) -> [Any] {
        let dict = dictionary as Array
        var resultArr = [Any]()
        var i = 0
        for point in dict {
            let pointEntity = Point(context: CoreDataManager.context) //Создаем сущность засовуем в контекст
            pointEntity.sity = point["sity"] as? String
            pointEntity.type = point["type"] as? String
            pointEntity.street = point["street"] as? String
            pointEntity.no = point["no"] as? String
            pointEntity.target_ru = point["target_ru"] as? String
            pointEntity.target_de = point["target_de"] as? String
            pointEntity.distance = point["distance"] as? Double ?? 0.0
            pointEntity.sort_number = Int16(i)
            resultArr.append(pointEntity)
            i += 1
        }
        return resultArr
    }
    
    private func createTripEntityFrom(dictionary: [String:AnyObject]) -> NSManagedObject? {
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: CoreDataManager.context) as? Trip {

            entity.id = dictionary["id"] as? String
            entity.trip_name = dictionary["trip_name"] as? String
            entity.odometer_start = dictionary["odometer_start"] as? String
            entity.odometer_start_img = dictionary["odometer_start_img"] as? String
            entity.odometer_end = dictionary["odometer_end"] as? String
            entity.odometer_end_img = dictionary["odometer_end_img"] as? String
            entity.direct_img = dictionary["direct_img"] as? String
            entity.refull = dictionary["refull"] as? String
            entity.fuel = dictionary["fuel"] as? String
            entity.gas = dictionary["gas"] as? String
            entity.gas_capacity = dictionary["gas_capacity"] as? String
            entity.gas_cost = dictionary["gas_cost"] as? String
            entity.gasoline = dictionary["gasoline"] as? String
            entity.gasoline_capacity = dictionary["gasoline_capacity"] as? String
            entity.gasoline_cost = dictionary["gasoline_cost"] as? String
            entity.fuel_capacity = dictionary["fuel_capacity"] as? String
            entity.cost = dictionary["cost"] as? String
            entity.routs = dictionary["routs"] as? String
            entity.start_point = dictionary["start_point"] as? String
            entity.date = dictionary["date"] as? String
            entity.time = dictionary["time"] as? String
            entity.persons = dictionary["persons"] as? String
                        
            if let pointsArr = dictionary["points"] as? NSArray {
                let pointsEntity =  createPointEntityFrom(dictionary: pointsArr, tripEntity: entity)
                entity.point = NSSet.init(array: pointsEntity)
            }
            
            entity.odometer_start_img_url = dictionary["odometer_start_img_url"] as? String
            entity.odometer_end_img_url = dictionary["odometer_end_img_url"] as? String
            return entity
        }
        return nil
    }
    
    func createNewEntity(entity: String) -> NSManagedObject? {
        switch entity {
        case "Trip":
            return (NSEntityDescription.insertNewObject(forEntityName: "Trip", into: CoreDataManager.context) as? Trip)

        case "User":
            return (NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataManager.context) as? User)

        default:
            return nil
        }
    }
    
    func saveInCoreDataEntityWith(entityName: String, array: [[String: AnyObject]]) -> Bool {
        switch entityName {
        case "User":
            clearData(forEntity: entityName)
            _ = array.map{self.createUserEntityFrom(dictionary: $0)}
            
        case "Trip":
            clearData(forEntity: "Point")
            clearData(forEntity: entityName)
            _ = array.map{self.createTripEntityFrom(dictionary: $0)}
            
        default:
            break
        }
        
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            return true
            
        } catch let error {
            print(error)
            return false
        }
    }
    
    private func clearData(forEntity: String) {
            do {
                let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: forEntity)
                do {
                    let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                    _ = objects.map{$0.map{context.delete($0)}}
                    CoreDataStack.sharedInstance.saveContext()
                    print("-CoreData: drop data for entity: \(forEntity)")
                } catch let error {
                    print("[!]CoreData: Clear CoreData for entity: \(forEntity) error : \(error)")
                }
            }
        }
    
    func getTrips() -> [Trip] {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        let result = [Trip]()
        do {
            let resultr = try CoreDataManager.context.fetch(fetchRequest)
            return resultr
            
        } catch let error as NSError {
            print(error.userInfo)
            return result
        }
    }
    
    func getUsers()-> [User]{
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            return result
            
        } catch let error as NSError {
            print(error.userInfo)
        }
        return [User]()
    }
}

