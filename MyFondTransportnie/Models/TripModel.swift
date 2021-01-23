//
//  CurrentTrip.swift
//  MyFondTransportnie
//
//  Created by Mac on 14.01.2021.
//

//import Foundation
//
//class TripModel {
//    let id, tripName, odometerStart, odometerStartImg: String
//    let odometerEnd, odometerEndImg: String
//    let directImg: String
//    let refull, fuel, gas, gasCapacity: String
//    let gasCost, gasoline, gasolineCapacity, gasolineCost: String
//    let fuelCapacity, cost, routs, startPoint: String
//    let date, time, persons: String
//    let point: [PointModel]
//    let odometerStartImgURL, odometerEndImgURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case tripName = "trip_name"
//        case odometerStart = "odometer_start"
//        case odometerStartImg = "odometer_start_img"
//        case odometerEnd = "odometer_end"
//        case odometerEndImg = "odometer_end_img"
//        case directImg = "direct_img"
//        case refull, fuel, gas
//        case gasCapacity = "gas_capacity"
//        case gasCost = "gas_cost"
//        case gasoline
//        case gasolineCapacity = "gasoline_capacity"
//        case gasolineCost = "gasoline_cost"
//        case fuelCapacity = "fuel_capacity"
//        case cost, routs
//        case startPoint = "start_point"
//        case date, time, persons, point
//        case odometerStartImgURL = "odometer_start_img_url"
//        case odometerEndImgURL = "odometer_end_img_url"
//    }
//
//    init(entity: Trip){
//        id = entity.id!
//        tripName = entity.trip_name!
//        odometerStart = entity.odometer_start!
//        odometerStartImg = entity.odometer_start_img!
//        odometerEnd = entity.odometer_end!
//        odometerEndImg = entity.odometer_end_img!
//        directImg = entity.direct_img!
//        refull = entity.refull!
//        fuel = entity.fuel!
//        gas = entity.gas!
//        gasCapacity = entity.gas_capacity!
//        gasCost = entity.gas_cost!
//        gasoline = entity.gasoline!
//        gasolineCapacity = entity.gasoline_capacity!
//        gasolineCost = entity.gasoline_cost!
//        fuelCapacity = entity.fuel_capacity!
//        cost = entity.cost!
//        routs = entity.routs!
//        startPoint = entity.start_point!
//        date = entity.date!
//        time = entity.time!
//        persons = entity.persons!
//        point = entity.point as [PointModel]
//        odometerStartImgURL = entity.odometer_start_img_url!
//        odometerEndImgURL = entity.odometer_end_img_url!
//    }
//}
//
//// MARK: - Point
//struct PointModel: Codable {
//    let type, sity, street, no: String
//    let targetRu, targetDe, distance: String?
//
//    enum CodingKeys: String, CodingKey {
//        case type, sity, street, no
//        case targetRu = "target_ru"
//        case targetDe = "target_de"
//        case distance
//        case sortNumber = "sort_number"
//    }
//}
