//
//  FixedAlarm.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import Foundation

struct Alarm {
    let id: UUID = UUID()
    var isOn: Bool = true
    var alarmName: String
    let createdAt: Date = Date()
    var transportationType: Transportation   // 교통수단
    var departurePlaceName: String           // ✅ 출발장소이름
    var destinationPlaceName: String         // ✅ 도착장소이름
    var departureLocation: Location?        // 출발지 좌표
    var destinationLocation: Location?      // 도착지 좌표
    var days: [DayOfWeek]                     // 선택 요일
    var arriveHour: Int                       // 도착 시
    var arriveMinute: Int                     // 도착 분
    var floatTime: Int                        // 도착까지 여유 시간
}
