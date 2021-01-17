//
//  Adress.swift
//  MyFondTransportnie
//
//  Created by Mac on 08.01.2021.
//

import Foundation

struct Address: Codable {
    let results: [FormattedAddress]
}

struct FormattedAddress: Codable {
    let formattedAddress: String
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
    }
    
}
