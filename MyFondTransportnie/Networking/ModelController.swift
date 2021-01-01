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
    
    class func auth(controller: ViewController, login: String, pass: String){
        if UserSettings.userModel?.userName == nil { // логика созданию юсер моделс? ошибка авторизации
            APIManager.authorize(login: login, pass: pass, completion: { result, error  in
                
                if let errors = error {
                    controller.showCustomAlert(title: "Ну ничего, страшного", message: errors.localizedDescription)
                    controller.setState(state: .fatalError(error!.localizedDescription))
                    return
                }
                
                switch result{
                case "OK":
                    let user = UserModel(userName: login)
                    UserSettings.userModel = user // Просто присваиваем обьект и он сохранится
                    controller.setState(state: .fetchengData)

                    
                case "incorrectUserAuthData":
                    controller.showAthorizeAlert(somethingIncorrect: true)
                    
                default:
                    //controller.showCustomAlert(title: "Неизвесный ответ сервера", message: result!)
                    controller.setState(state: .fatalError(result ?? "Неизвестный ответ сервера"))
                }
            })
        } else {
            self.getTrips(VC: controller)
        }
    }
    
    class func saveTrips(trips: [Trip]){

        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Tripp", in: context)
        let trips = NSManagedObject(entity: entity!, insertInto: context) as! Trip

        do {
            try context.save()
            print("is save")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func getTrips(VC: ViewController){
        APIManager.fetchTrips(completion: { result in
                                switch result{//тут полчили результат из APIManager
                                case .Success(let trips):
                                    let CDM = CoreDataManager()
                                    CDM.clearData(forEntity: "Trip")
                                    CDM.saveInCoreDataTripWith(array: trips) // и сохранием в CoreData
                                    VC.setState(state: .normal)
                                    
                                case .Error(let error):
                                    print(error)
                                    // вывести ошибку в кастом алерт, отправить в коллектор ошибок
                                    VC.setState(state: .fatalError(error.debugDescription))
                                    return
                                }        })
    }
    
    class func getUsers(VC: ViewController){
        APIManager.fetchUsers(completion: { result, error  in
            switch result{//тут полчили результат из APIManager
            case .Success(let users):
                let CDM = CoreDataManager()
                CDM.clearData(forEntity: "User")
                CDM.saveInCoreDataWith(array: users) // и сохранием в CoreData
                VC.setState(state: .normal)
                
            case .Error(let error):
                print(error)
                // вывести ошибку в кастом алерт, отправить в коллектор ошибок
                VC.setState(state: .fatalError(error.debugDescription))
                return
            }
        })
    }
}


