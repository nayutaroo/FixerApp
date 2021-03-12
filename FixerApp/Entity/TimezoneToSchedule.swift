//
//  TimezoneToSchedule.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/19.
//

import Foundation

class TimezoneToSchedule {
    static let shared = TimezoneToSchedule()
    
    func scheduleDataInit(timezones: [Timezone]) {

// TODO:
//        //[Timezone]の数だけ繰り返し
//        var index = 0
//        for timezone in timezones {
//          
//            var i = 0
//            //selectedDateから行番号を特定
//            for date in selectedDate {
//                if date.compare(timezone.date) == .orderedSame {
//                    break
//                }
//                i += 1
//            }
//         
//            //開始時間からの計算を行なってselectedDataの値を決定
//            var j = timezones[index].from - 16 //16時からの調整なので定義しているが後々変更する
//            while j < timezones[index].to - 16 {
//                scheduleData[i][j] = timezones[index].timezoneStatus()
//                j += 1
//            }
//            index += 1
//        }
    }
    
}
