//
//  Timezone.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/01.
//

import Foundation

struct Schedule: Decodable{
    let users: [User]
    let date: [Date]
    let from: Int
    let to: Int
}

struct User: Decodable{
    let id: String
}

struct json: Decodable{
    let timezones: [Timezone]
}

struct Timezone: Codable{
    let date: Date
    let from: Int
    let to: Int
    private let status: Int
    
    init(date: Date, from: Int, to: Int, status: Int) {
        self.date = date
        self.from = from
        self.to = to
        self.status = status
    }
    
    func timezoneStatus() -> TimeZoneStatus{
        switch status{
        case 0:
            return .available
        case 1:
            return .undecided
        case 2:
            return .unavailable
        default:
            return .undefined
        }
    }
}
