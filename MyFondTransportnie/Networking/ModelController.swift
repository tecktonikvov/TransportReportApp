//
//  DataManager.swift
//  MyFondTransportnie
//
//  Created by Mac on 25.12.2020.
//

import Foundation
import UIKit
import CoreData

class ModelController {
    static var vc: ViewController!
    class func authFromAPI(login: String, pass: String){
        if UserSettings.userModel?.userName == nil { // логика созданию юсер моделс? ошибка авторизации
            APIManager.authorize(login: login, pass: pass, completion: { result, error  in
                
                if let errors = error {
                    vc.showCustomAlert(title: "Ну ничего, страшного", message: errors.localizedDescription)
                    vc.setState(state: .fatalError(error!.localizedDescription))
                    return
                }
                
                switch result{
                case "OK":
                    let user = UserModel(userName: login)
                    UserSettings.userModel = user // Просто присваиваем обьект и он сохранится
                    vc.setState(state: .fetchengData)

                    
                case "incorrectUserAuthData":
                    vc.showAthorizeAlert(somethingIncorrect: true)
                    
                default:
                    //controller.showCustomAlert(title: "Неизвесный ответ сервера", message: result!)
                    vc.setState(state: .fatalError(result ?? "Неизвестный ответ сервера"))
                }
            })
        } else {
            self.getTripsFromAPI()
        }
    }
    
    class func getTripsFromAPI(){
        APIManager.fetchTrips(completion: { result in
      
                                switch result{//тут получили результат из APIManager
                                case .Success(let trips):
                                    let CDM = CoreDataManager()
                                    CDM.clearData(forEntity: "Trip")
                                    CDM.saveInCoreDataTripWith(array: trips) // и сохранием в CoreData
                                    CDM.getTrips()
                                    vc.setState(state: .normal)
                                    
                                case .Error(let error):
                                    print(error)
                                    // вывести ошибку в кастом алерт, отправить в коллектор ошибок
                                    vc.setState(state: .fatalError(error.debugDescription))
                                    return
                                }        })
    }
    
    class func getUsersFromAPI(){
        APIManager.fetchUsers(completion: { result, error  in
            switch result{//тут полчили результат из APIManager
            case .Success(let users):
                let CDM = CoreDataManager()
                CDM.clearData(forEntity: "User")
                CDM.saveInCoreDataUserWith(array: users) // и сохранием в CoreData
                vc.setState(state: .normal)
                //print(users)
                
            case .Error(let error):
                print(error)
                // вывести ошибку в кастом алерт, отправить в коллектор ошибок
                vc.setState(state: .fatalError(error.debugDescription))
                return
            }
        })
    }
    
    class func getTripsFromCoreData(){
        let CDM = CoreDataManager()
        CDM.getTrips()
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
}


