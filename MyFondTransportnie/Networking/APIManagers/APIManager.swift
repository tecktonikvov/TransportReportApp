//
//  APIManager.swift
//  MyFondTransportnie
//
//  Created by Mac on 13.12.2020.
//

import Foundation
import CoreData
import Alamofire

class APIManager: NSObject{
    
    enum Result <T>{
    case Success(T)
    case Error(String)
    }
    
    static let token = "ca1cecb73dc49d9cf54565c258b4a5bd"
    static var trips = [Trip]()
    
    class func authorize(login: String, pass: String, completion: @escaping (String?, Error?)->()) {
        AF.request("http://192.168.1.6/managment/api?token=\(token)&action=auth&user=\(login)&pass=\(pass)", requestModifier: { $0.timeoutInterval = 3 })
            .validate()
            .responseJSON { response in

                switch (response.result) {
                case .success( _):
                    if response.description == "success(OK)"{
                        completion("OK", nil)
                    } else if response.description == "success(incorrect login or pass)" {
                        completion("incorrectUserAuthData", nil)
                    } else {
                        completion(response.description, nil)
                    }
                    
                case .failure(let error):
                    //print("Request error: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
    }
    
    class func fetchTrips(completion: @escaping (Result<[[String:AnyObject]]>) -> ()) {
        let login = "Koz"
        AF.request("http://192.168.1.6/managment/api?token=\(token)&action=getTrips&user=\(login)&pass=Koz", requestModifier: { $0.timeoutInterval = 3 })
            .validate()
            .responseJSON { response in

                switch (response.result) {
                case .success( _):
                    completion(.Success(response.value as! [[String:AnyObject]]))
                    
                case .failure(let error):
                    completion(.Error(error.localizedDescription))
                    //print("Request error: \(error.localizedDescription)")
                }
            }
    }
    
    class func fetchUsers(completion: @escaping (Result<[[String:AnyObject]]>, Error?) -> Void) {
        // Все начинается тут. Мы получаем JSON от нашего API используя библиотеку Alamofire
        // И передаем complitionHandler-ом результат, метод вызывается в DataManager
        let login = "Koz"
        AF.request("http://192.168.1.6/managment/api?token=\(token)&action=getUsers&user=\(login)&pass=Koz")
            .validate()
            .responseJSON { response in
                switch (response.result) {
                case .success( _):
                    completion(.Success(response.value as! [[String:AnyObject]]), nil)
                    
                case .failure(let error):
                    completion(.Error(error.localizedDescription), error)
                    //print("Request error: \(error.localizedDescription)")
                    //print(error)
                }
            }
    }
}
