//
//  User.swift
//  MyFondTransportnie
//
//  Created by Mac on 27.12.2020.
//

import Foundation

class Userr: Codable {
    let active, nameRu, surnameRu, nameEn: String
    let surnameEn, abbrev, type: String

    enum CodingKeys: String, CodingKey {
        case active
        case nameRu = "name_ru"
        case surnameRu = "surname_ru"
        case nameEn = "name_en"
        case surnameEn = "surname_en"
        case abbrev, type
    }

}

