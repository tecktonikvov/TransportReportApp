//
//  DataManager.swift
//  MyFondTransportnie
//
//  Created by Mac on 25.12.2020.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    static var vc: ViewController!
    
    class func authFromAPI(login: String, pass: String){
        if UserSettings.userModel?.userName == nil { // логика созданию юсер моделс? ошибка авторизации
            APIManager.authorize(login: login, pass: pass, completion: { result, error  in
                
                if let errors = error {
                    vc.showCustomAlert(title: "Ну ничего, страшного", message: errors.localizedDescription)
                    vc.setState(state: .fatalError(error!.localizedDescription))
                    return
                }
                
                switch result {
                case "OK":
                    let user = UserModel(userName: login)
                    UserSettings.userModel = user // Просто присваиваем обьект и он сохранится
                    vc.setState(state: .fetchengData)
                    
                case "incorrectUserAuthData":
                    vc.showAthorizeAlert(somethingIncorrect: true)
                    
                default:
                    vc.setState(state: .fatalError(result ?? "Неизвестный ответ сервера"))
                }
            })
        } else {
            self.getTrips()
        }
    }
    
    class func getTrips(){
        APIManager.fetchTrips(completion: { result in
            switch result{//тут получили результат из APIManager
            case .Success(let trips):
                
                if trips.count != 0 {
                    saveEntityToCoreData(entityName: "Trip", dictionary: trips)
                    getTripsFromCoreData()
                    vc.setState(state: .normal)
                    
                } else {
                    getTripsFromCoreData()
                    vc.setState(state: .autonomicMode)
                    print("[!]DataManager: Warning: API send 0 trips!")
                }
                
            case .Error(let error):
                //print(error)
                getTripsFromCoreData()
                vc.setState(state: .autonomicMode)
                return
            }
        })
    }
    
    class func fetchUsersFromAPI(){
        APIManager.fetchUsers(completion: { result, error  in
            switch result{//тут полчили результат из APIManager
            case .Success(let users):
                saveEntityToCoreData(entityName: "User", dictionary: users)
                vc.setState(state: .normal)

            case .Error(let error):
                //print(error)
                vc.setState(state: .autonomicMode)
                //vc.setState(state: .fatalError("Не возможно получить юсеров из API"))
                return
            }
        })
    }
    
    class func getNewEntity(entityName: String) -> Trip {
        let CDM = CoreDataManager()
        return CDM.createNewEntity(entity: "Trip") as! Trip
    }
    
    class func getTripsFromCoreData(){
        let CDM = CoreDataManager()
        let result = CDM.getTrips()
        
        if result.isEmpty {
            print("[!]DataManager: Can`t get Trips from CoreData, result is empty")
            vc.state = .fatalError("Не возможно получить поездки из CoreData")
        }
        vc.trips = result
    }
    
    class func getUsersFromCoreData() -> [User]{
        let CDM = CoreDataManager()
        let result = CDM.getUsers()
        
        if result.isEmpty {
            print("[!]DataManager: Can`t get Users from CoreData, result is empty")
            vc.state = .fatalError("Невозможно получить пользователей из CoreData")
        }
        return result
    }
    
    class func saveEntityToCoreData(entityName: String, dictionary: [[String: AnyObject]]){
        let CDM = CoreDataManager()
        
        switch entityName {
        case "User":
            if CDM.saveInCoreDataEntityWith(entityName: entityName, array: dictionary) {
                print("+DataManager: Save \"Users\" to CoreDAta success")
            } else {
                print("[!]DataManager: Can`t save Users to CoreData")
            }
            
        case "Trip":
            if CDM.saveInCoreDataEntityWith(entityName: entityName, array: dictionary){
                print("+DataManager: Save \"Trips\" to CoreDAta success")
            } else {
                print("[!]DataManager: Can`t save Trips to CoreData")
            }
            
        default:
            break
        }
    }

    class func getUsersStringArrray(byProf: String) -> [String]{
        let profType = byProf
        let CDM = CoreDataManager()
        let users = CDM.getUsers()
        var usersArr = [String]()
        for user in users {
            guard let name = user.name_ru, let surname = user.surname_ru else { return [String()] }
            if user.type! == profType {
                usersArr.append(name + " " + surname)
            }
        }
        return usersArr
    }
    
    class func getAddresFromGeoAPI(){
        APIGeocodingManager.fetchTrips(completion: { result in
            switch result{
            case .Success(let json):
                let decoder = JSONDecoder()
                let str = try! decoder.decode(Address.self, from: json)
                let resultAddress = str.results.first
                print("---------------------------------------")
                print(resultAddress!)
                print("---------------------------------------")

            case.Error(let error):
                print(error)
            }
        })
    }
}


