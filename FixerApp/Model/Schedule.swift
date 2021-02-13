//
//  Schedule.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/01.
//

import Foundation

// 一覧画面
//GET (index/:User.id) → そのユーザが参加しているイベント  user_id → [Event]

// 詳細画面
//GET (detail/:Event.id) → 指定した範囲の時間帯のuserごとのタイムゾーンをとってくる
            // [users] → [TimezonesByUser]

// 入力画面
// GET (input/  :User.id, Event.id) → TimezonesByUser

// 新しい時間帯の入力をする場合はクライアント側で判断し×とする。
// POST (input) → Times

//イベント(Event)

struct Event : Codable {
    let id: Int
    let name: String
    let makerId: String                     // LINEのID次第でIntかStringかが変わる
    let enteredUsers: [User]
    let unenteredUsers: [User]
    let timezones: [Timezone]               // スケジュールの入力する日程（時間帯）の範囲
    let deadline: Date                      // 〆切日
    let possibleTimezones: [Timezone]       // 候補時間帯 16日 13時〜17時, 17日 18時〜19時
    let isDecided: Bool                     // 確定されてるかどうか
    let decidedTimezone: Timezone?          // 確定した時間帯
}

//ユーザ
struct User: Codable {
    let id: String
    let name: String
    let imageURL: URL?
    
//    init(id: String, name: String, imageURL : URL?) {
//        self.id = id
//        self.name = name
//        self.imageURL = imageURL
//    }
}

//ユーザごとのタイムゾーン
struct TimezonesByUser: Decodable {
    let userId: String
    let timezones: [Timezone] //ユーザごの時間帯の情報管理
}

//タイムゾーン
struct Timezone: Codable{
    let date: Date //日付
    let from: Int  //〜時から
    let to: Int    //〜時まで
    private let status: Int  // 0: ○ 1: △ 2: × 3: unknown
    
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


