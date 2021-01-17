//
//  APIGeocodingManager.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.01.2021.
//

import Foundation
import Alamofire

class APIGeocodingManager {
    
    enum Result <T>{
    case Success(T)
    case Error(String)
    }
    
    static let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=46.9535458,32.0145134&key=AIzaSyAKyLUBpsAGAPKDsapC_ca0Nj0Cty9dS3E&language=ru"
    
    class func fetchTrips(completion: @escaping (Result<Data>) -> ())   {
        
        AF.request(url, requestModifier: { $0.timeoutInterval = 3 })
            .validate()
            .responseJSON { response in

                switch (response.result) {
                case .success( _):
                    let res = response.data!
                    completion(.Success(res))
                    
                case .failure(let error):
                    completion(.Error(error.localizedDescription))
                }
            }
    }
}
