//
//  CoreDataManager.swift
//  MyFondTransportnie
//
//  Created by Mac on 21.12.2020.
//

import Foundation
import CoreData

class CoreDataManager {
    static var vc: ViewController!
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
    
    private func createTripEntityFrom(dictionary: [String:AnyObject]) -> NSManagedObject? {
        if let userEntity = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: CoreDataManager.context) as? Trip {
            userEntity.id = dictionary["id"] as? String
            userEntity.trip_name = dictionary["trip_name"] as? String
            userEntity.odometer_start = dictionary["odometer_start"] as? String
            userEntity.odometer_start_img = dictionary["odometer_start_img"] as? String
            userEntity.odometer_end = dictionary["odometer_end"] as? String
            userEntity.odometer_end_img = dictionary["odometer_end_img"] as? String
            userEntity.direct_img = dictionary["direct_img"] as? String
            userEntity.refull = dictionary["refull"] as? String
            userEntity.fuel = dictionary["fuel"] as? String
            userEntity.gas = dictionary["gas"] as? String
            userEntity.gas_capacity = dictionary["gas_capacity"] as? String
            userEntity.gas_cost = dictionary["gas_cost"] as? String
            userEntity.gasoline = dictionary["gasoline"] as? String
            userEntity.gasoline_capacity = dictionary["gasoline_capacity"] as? String
            userEntity.gasoline_cost = dictionary["gasoline_cost"] as? String
            userEntity.fuel_capacity = dictionary["fuel_capacity"] as? String
            userEntity.cost = dictionary["cost"] as? String
            userEntity.routs = dictionary["routs"] as? String
            userEntity.start_point = dictionary["start_point"] as? String
            userEntity.date = dictionary["date"] as? String
            userEntity.time = dictionary["time"] as? String
            userEntity.persons = dictionary["persons"] as? String
            userEntity.points = dictionary["points"] as? String
            userEntity.odometer_start_img_url = dictionary["odometer_start_img_url"] as? String
            userEntity.odometer_end_img_url = dictionary["odometer_end_img_url"] as? String
            return userEntity
        }
        return nil
    }
    
    func saveInCoreDataTripWith(array: [[String: AnyObject]]) {
            _ = array.map{self.createTripEntityFrom(dictionary: $0)} // это функция высокого порядка
        //$0 представляет каждый из елементов array используя замыкание, в котором вы можете выполнять другие функции к каждому из этих элементов
        // на вход createUserEntityFrom() при помощи array.map() мы передаем по одному елементу массива array где он инициализируется
        // как userEntity и добавляется в контекст
            do {
                try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
                print("Save trip success")
            } catch let error {
                print(error)
            }
        }
    
    func saveInCoreDataUserWith(array: [[String: AnyObject]]) {
            _ = array.map{self.createUserEntityFrom(dictionary: $0)} 
            do {
                try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
                // и сохранияем контекст
            } catch let error {
                print(error)
            }
        }
    
    func clearData(forEntity: String) {
            do {
                let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: forEntity)
                do {
                    let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                    _ = objects.map{$0.map{context.delete($0)}}
                    CoreDataStack.sharedInstance.saveContext()
                } catch let error {
                    print("ERROR DELETING : \(error)")
                }
            }
        }
    
    func getTrips(){
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            if result.isEmpty {
                print("Cant fetch Trips in function: \(#function) file: \(#file)")
            }
            CoreDataManager.vc.trips = result
            
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    func getUsers()-> [User]{
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            if result.isEmpty {
                print("Cant fetch Users in function: \(#function) file: \(#file)")
            }
            print("Users from coreData fetched in count: \(result.count)")
            return result
            
        } catch let error as NSError {
            print(error.userInfo)
        }
        return [User()]
    }
    
    
}
