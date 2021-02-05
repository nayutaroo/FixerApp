//
//  Schedule.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/01.
//

import Foundation

struct Schedule : Decodable {
    let name: String
    let makerId: String                     //LINEのID次第でIntかStringかが変わる
    let entetedUsers: [User]
    let unenteredUsers: [User]
    let timezones: [Timezone]
    let deadline: Date                      //〆切日
    let possibleTimezones: [Timezone]       //候補時間帯
    let isDecided: Bool
    let decidedTimezone: Timezone?          //確定した時間帯
}

struct User: Decodable {
    let id: String
    let name: String
    let imageURL: URL?
}

struct TimezonesByUser: Decodable {
    let userId: String
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
    
    //サーバ側でUserが持っているスケジュールに関する情報を取り出す。
    //一覧画面表示時にユーザIDが無効に知れ渡り向こうからそれに対応するスケジュール情報を表示するイメージで
    //関係図は分けて書くべき？それとも合わせてもOK？
    //Users <-> Schedules （多対多）
}


//struct UnEnteredSchedule: ScheduleProtocol {
//    var users: [User]
//    var timezones: [Timezone]
//    var name: String
//    var makerId: String
//}
//
//struct EnteredSchedule: ScheduleProtocol {
//    var users: [User]
//    var timezones: [Timezone]
//    var name: String
//    var makerId: String
//    let candidateTimezone: [Timezone]
//}
//
//struct decidedSchedule: ScheduleProtocol {
//    var users: [User]
//    var timezones: [Timezone]
//    var name: String
//    var makerId: String
//    let decidedTimezone: Timezone
//}
