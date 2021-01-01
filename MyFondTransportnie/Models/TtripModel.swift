//
//  DataStruct.swift
//  MyFondTransportnie
//
//  Created by Mac on 10.12.2020.
//

import Foundation
import CoreData

//class Trip: Codable {
//        let id, tripName, odometerStart, odometerStartImg: String?
//        let odometerEnd, odometerEndImg, directImg, refull: String?
//        let fuel, gas, gasCapacity, gasCost: String?
//        let gasoline, gasolineCapacity, gasolineCost, fuelCapacity: String?
//        let cost, routs, startPoint, date: String?
//        let time: String?
//        let persons: [Person]?
//        let points: [Point]?
//        let odometerStartImgURL, odometerEndImgURL: String?
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case tripName = "trip_name"
//            case odometerStart = "odometer_start"
//            case odometerStartImg = "odometer_start_img"
//            case odometerEnd = "odometer_end"
//            case odometerEndImg = "odometer_end_img"
//            case directImg = "direct_img"
//            case refull, fuel, gas
//            case gasCapacity = "gas_capacity"
//            case gasCost = "gas_cost"
//            case gasoline
//            case gasolineCapacity = "gasoline_capacity"
//            case gasolineCost = "gasoline_cost"
//            case fuelCapacity = "fuel_capacity"
//            case cost, routs
//            case startPoint = "start_point"
//            case date, time, persons, points
//            case odometerStartImgURL = "odometer_start_img_url"
//            case odometerEndImgURL = "odometer_end_img_url"
//        }
//
//    }
//
    struct Person: Codable {
        let abbrev, role, nameRu, nameDe: String
            let surnameRu, surnameDe: String

            enum CodingKeys: String, CodingKey {
                case abbrev, role
                case nameRu = "name_ru"
                case nameDe = "name_de"
                case surnameRu = "surname_ru"
                case surnameDe = "surname_de"
            }
    }

//    //    [{"abbrev":"Koz","role":"IT","name_ru":"Владимир","name_de":"Wladimir","surname_ru":"Коцюбенко","surname_de":"Kozjubenko"},{"abbrev":"BW","role":"Per","name_ru":"Валерия","name_de":"Walerija","surname_ru":"Берщадская","surname_de":"Berschadskaja"}]
//
//
//    }
//
    struct Point: Codable {
        let type, sity, street, no: String
           let targetRu, targetDe, distance: String?

           enum CodingKeys: String, CodingKey {
               case type, sity, street, no
               case targetRu = "target_ru"
               case targetDe = "target_de"
               case distance
           }
    }

////    {"type":"parking","sity":"Николаев / Nikolaev","street":"Чкалова / Chkalova","no":"25а"},
////    {"type":"point","sity":"Воскресенское / Woskresenskoje","street":"ул. Почтовая / ul. Potschtowaja","no":"3","target_ru":"Фотосъемка Дубровиной","target_de":"Hausfotoset von Dubrovina","distance":"17.9"},
////    {"type":"point","sity":"Николаев / Nikolaev","street":"ул. Спасская / ul. Spaskaja","no":"52","target_ru":"Забирал картриджи в CNT ","target_de":"","distance":"16.9"},
////    {"type":"parking","sity":"Николаев / Nikolaev","street":"Чкалова / Chkalova","no":"25а","target_ru":"Возвращение на стоянку","target_de":"Fahrt zum Parkplatz","distance":"1.2"}
//
//}


